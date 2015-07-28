class Bug < ActiveRecord::Base

  filterrific(
      default_filter_params: { :sorted_by => 'published_time_desc', :cols=>'-'},
      available_filters: [
          :q,
          :with_cloud,
          :with_money,
          :with_hide,
          :sorted_by,
          :cols,
      ]
  )

  scope :cols, lambda { |query|
                  select('id, wid, title, ismoney, iscloud, ishide, created_time, published_time')
                }

  scope :q, lambda { |query|
       return nil if query.blank?
       query = query.downcase
       where("title LIKE ? or content LIKE ?", "%#{query}%", "%#{query}%")
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

  scope :sorted_by, lambda { |sort_option|
                    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
                    case sort_option.to_s
                      when /^created_time_/
                        order("created_time #{ direction }, published_time #{ direction }")
                      when /^published_time_/
                        order("published_time #{ direction }, created_time #{ direction }")
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

    ]
  end

end
