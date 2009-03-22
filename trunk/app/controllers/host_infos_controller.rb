class HostInfosController < ApplicationController
  require 'paginator'
  # GET /host_infos
  # GET /host_infos.xml
  def index
   where = {}
   @url_params = {}
   @sort_by = nil
   @sort_dir = nil
   order_clause = nil
   if session[:tablen].nil?
	session[:tablen] = 20
   end

    if not params[:hostname_v].nil?
      where[:hostname] = params[:hostname_v]
      @url_params[:hostname_v] = params[:hostname_v]
    end

    if not params[:host_id_v].nil?
      where[:host_id] = params[:host_id_v]
      @url_params[:host_id_v] = params[:host_id_v]
    end

    if not params[:sort_by].nil?

      if params[:sort_by] == "ip_address"
        @sort_by = "ip_address"
      end

      if params[:sort_by] == "test_area_name"
        @sort_by = "test_area_name"
      end

      if params[:sort_by] == "key"
        @sort_by = "key"
      end

      if params[:sort_by] == "value"
        @sort_by = "value"
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

   if not params[:key_v].nil?
     where[:key] = params[:key_v]
     @url_params[:key_v] = params[:key_v]
   end

   if not params[:value_v].nil?
     where[:value] = params[:value_v]
     @url_params[:value_v] = params[:value_v]
   end

  if session[:test_area].nil?
    @record_count = HostInfo.find(:all, :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
    HostInfo.find(:all, :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  else
    @record_count = HostInfo.find_all_by_test_area_id(session[:test_area], :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
    HostInfo.find_all_by_test_area_id(session[:test_area], :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  end

  @host_infos = @pager.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @host_infos }
    end
  end

end
