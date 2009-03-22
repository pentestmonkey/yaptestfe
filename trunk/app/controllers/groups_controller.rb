class GroupsController < ApplicationController
  require 'paginator'

  # GET /groups
  def index
   where = {}
   @url_params = {}
   @sort_by = nil
   @sort_dir = nil
   order_clause = nil
   if session[:tablen].nil?
	session[:tablen] = 20
   end

    if not params[:sort_by].nil?

      if params[:sort_by] == "group_ip"
        @sort_by = "group_ip"
      end

      if params[:sort_by] == "test_area_name"
        @sort_by = "test_area_name"
      end

      if params[:sort_by] == "group_name"
        @sort_by = "group_name"
      end

      if params[:sort_by] == "member_ip"
        @sort_by = "member_ip"
      end

      if params[:sort_by] == "member_domain"
        @sort_by = "member_domain"
      end

      if params[:sort_by] == "member_name"
        @sort_by = "member_name"
      end

      if not @sort_by.nil?
        if params[:sort_dir] == "desc"
          @sort_dir = "desc"
        else
          @sort_dir = "asc"
        end

        order_clause = "#{@sort_by} #{@sort_dir}"
      end
   end


   if not params[:group_ip_v].nil?
     where[:group_ip] = params[:group_ip_v]
     @url_params[:group_ip_v] = params[:group_ip_v]
   end

   if not params[:group_name_v].nil?
     where[:group_name] = params[:group_name_v]
     @url_params[:group_name_v] = params[:group_name_v]
   end

   if not params[:member_ip_v].nil?
     where[:member_ip] = params[:member_ip_v]
     @url_params[:member_ip_v] = params[:member_ip_v]
   end

   if not params[:member_domain_v].nil?
     where[:member_domain] = params[:member_domain_v]
      @url_params[:member_domain_v] = params[:member_domain_v]
   end

   if not params[:member_name_v].nil?
     where[:member_name] = params[:member_name_v]
     @url_params[:member_name_v] = params[:member_name_v]
   end

  if session[:test_area].nil?
    @record_count = Group.find(:all, :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      Group.find(:all, :order => "group_ip asc", :limit => per_page, :offset => offset, :conditions => where)
    end
  else
    @record_count = Group.find_all_by_group_test_area_id(session[:test_area], :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
    Group.find_all_by_group_test_area_id(session[:test_area], :order => "group_ip asc", :limit => per_page, :offset => offset, :conditions => where)
    end
  end

    @groups = @pager.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

end
