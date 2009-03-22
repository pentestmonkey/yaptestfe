class IssuesController < ApplicationController
  require 'paginator'
  # GET /issues
  # GET /issues.xml
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

      if params[:sort_by] == "ip_address"
        @sort_by = "ip_address"
      end

      if params[:sort_by] == "test_area_name"
        @sort_by = "test_area_name"
      end

      if params[:sort_by] == "port"
        @sort_by = "port"
      end

      if params[:sort_by] == "transport_protocol"  # TODO BROKEN
        @sort_by = "transport_protocol_name"
      end

      if params[:sort_by] == "issue_shortname"
        @sort_by = "issue_shortname"
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

   if not params[:host_id_v].nil?
     @host_menu = 1
     @host = Host.find(params[:host_id_v])
     @page_title="Issues on #{@host.ip_address} in area #{@host.test_area_name}"
     where[:host_id] = params[:host_id_v]
     @url_params[:host_id_v] = params[:host_id_v]
   end

   if not params[:issue_v].nil?
     where[:issue_shortname] = params[:issue_v]
     @url_params[:issue_v] = params[:issue_v]
   end

   if not params[:port_v].nil?
     where[:port] = params[:port_v]
     @url_params[:port_v] = params[:port_v]
   end

   if not params[:trans_v].nil?
     where[:transport_protocol_name] = params[:trans_v]
     @url_params[:trans_v] = params[:trans_v]
   end

  if session[:test_area].nil?
    @record_count = Issue.find(:all, :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
    Issue.find(:all, :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  else
    @record_count = Issue.find_all_by_test_area_id(session[:test_area], :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
    Issue.find_all_by_test_area_id(session[:test_area], :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  end
  @issues = @pager.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @issues }
    end
  end

  # GET /issues/1
  # GET /issues/1.xml
  def show
    @issue = Issue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @issue }
    end
  end

end
