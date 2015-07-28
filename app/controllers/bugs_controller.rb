class BugsController < ApplicationController
  before_action :set_bug, only: [:show]

  # GET /bugs
  # GET /bugs.json
  def index
    page = params[:page].to_i || 1
    page = 1 if page==0
    per_page = params[:per_page].to_i || 20
    per_page = 20 if per_page==0
    per_page = 100 if per_page>100

    @filterrific = initialize_filterrific(
        Bug,
        params[:filterrific] ||= {filterrific_reset: true, sorted_by: 'published_time_desc'},
        :select_options => {
            sorted_by: Bug.options_for_sorted_by
        }
    ) or return

    @with_cloud_set = (filterrific_params[:with_cloud].to_i==1)
    @with_money_set = (filterrific_params[:with_money].to_i==1)
    @with_hide_set = (filterrific_params[:with_hide].to_i==1)
    @bugs = @filterrific.find.paginate(page:page, per_page:per_page) #'
    #@bugs = Bug.select("id, wid, title, ismoney, iscloud, ishide, created_time, published_time").order('published_time desc, created_time desc').paginate(page:page, per_page:per_page)#select("id, wid, title, ismoney, iscloud, ishide, created_time, published_time").order('published_time desc, created_time desc')
  end

  # GET /bugs/1
  # GET /bugs/1.json
  def show

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bug
      if params[:id].include? '-'
        wmid = params[:id].split('-')[2].to_i
        @bug = Bug.find_by_wmid(wmid)
      else
        @bug = Bug.find(params[:id])
      end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bug_params
      params.require(:bug).permit(:id, :wid, :wmid, :page, :per_page)
    end

    def filterrific_params
      params.require(:filterrific).permit(:q, :with_cloud, :with_money, :with_hide, :sorted_by, :page, :per_page)
    end
end

