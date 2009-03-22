class IcmpsController < ApplicationController
  require 'paginator'
  # GET /icmps
  # GET /icmps.xml
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

      if params[:sort_by] == "icmp_name"
        @sort_by = "icmp_name"
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
     @host = Host.find_by_host_id(params[:host_id_v])
     @page_title="ICMP Info #{@host.ip_address} in area #{@host.test_area_name}"
     where[:host_id] = params[:host_id_v]
     @url_params[:host_id_v] = params[:host_id_v]
   end

   if not params[:type_v].nil?
     where[:icmp_name] = params[:type_v]
     @url_params[:type_v] = params[:type_v]
   end


    # @icmps = Icmp.find(:all, :order => "icmp")
  if session[:test_area].nil?
    @record_count = Icmp.find(:all, :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      Icmp.find(:all, :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  else
    @record_count = Icmp.find_all_by_test_area_id(session[:test_area], :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      Icmp.find_all_by_test_area_id(session[:test_area], :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  end
  @icmps = @pager.page(params[:page])
    # TODO: order by hosts.ip_address, icmp

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @icmps }
    end
  end

  # GET /icmps/1
  # GET /icmps/1.xml
  def show
    @icmp = Icmp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @icmp }
    end
  end

end
