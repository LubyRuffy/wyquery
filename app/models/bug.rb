class Bug < ActiveRecord::Base

  filterrific(
      default_filter_params: { :select_cols=>'test', :sorted_by => 'published_time_desc'},
      available_filters: [
          :q,
          :author,
          :corporation,
          :with_cloud,
          :with_money,
          :with_hide,
          :sorted_by,
          :rank_range,
          :select_cols,
      ]
  )

  scope :select_cols, lambda { |query|
                  select('id, wid, title, ismoney, iscloud, ishide, created_time, published_time, rank')
                }

  scope :q, lambda { |query|
       return nil if query.blank?
       query = query.downcase
       where("title LIKE ? or content LIKE ?", "%#{query}%", "%#{query}%")
  }

  scope :author, lambda { |query|
            return nil if query.blank?
            query = query.downcase
            where("author LIKE ?", "%#{query}%")
          }

  scope :corporation, lambda { |query|
                 return nil if query.blank?
                 query = query.downcase
                 where("corporation LIKE ?", "%#{query}%")
               }

  scope :with_cloud, lambda { |flag|
     check_boolean_attr "iscloud", flag
   }

  scope :with_money, lambda { |flag|
                     check_boolean_attr "ismoney", flag
                   }

  scope :with_hide, lambda { |flag|
                     check_boolean_attr "ishide", flag
                   }

  scope :rank_range, lambda {|query|
                     return nil if query.blank?
                     query = query.downcase
                     b,e = query.split('-')
                     return nil if b.nil? || e.nil?
                     b = b.to_i
                     e = e.to_i
                     return nil if b<0 || b>20 || e<0 || e>20
                     where("rank>=? and rank<= ?", b, e)
                   }

  scope :sorted_by, lambda { |sort_option|
                    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
                    case sort_option.to_s
                      when /^created_time_/
                        order("created_time #{ direction }, published_time #{ direction }")
                      when /^published_time_/
                        order("published_time #{ direction }, created_time #{ direction }")
                      when /^rank_/
                        order("rank #{ direction }, published_time #{ direction }, created_time #{ direction }")
                      when /^diff_time/
                        where("strftime('%s', published_time)-strftime('%s', created_time)>0").order("(strftime('%s', published_time)-strftime('%s', created_time)) #{ direction }")
                      else
                        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
                    end
                  }

  def self.check_boolean_attr attr_name, attr_value
    return nil  if 0 == attr_value.to_i
    where(attr_name.to_sym => true)
  end

  def self.options_for_sorted_by
    [
        ['公开时间倒序', 'published_time_desc'],
        ['公开时间顺序', 'published_time_asc'],
        ['提交时间倒序', 'created_time_desc'],
        ['提交时间顺序', 'created_time_asc'],
        ['提交时间和公开时间差异倒序', 'diff_time_desc'],
        ['提交时间和公开时间差异顺序', 'diff_time_asc'],
        ['RANK排序', 'rank_desc'],
    ]
  end

  def self.options_for_rank_range
    [
        ['所有Rank', '0-20'],
        ['0-5', '0-5'],
        ['6-10', '6-10'],
        ['11-15', '11-15'],
        ['16-20', '16-20'],
    ]
  end

end
