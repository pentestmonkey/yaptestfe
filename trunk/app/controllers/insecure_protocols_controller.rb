class InsecureProtocolsController < ApplicationController
  require 'paginator'
  # GET /insecure_protocol
  # GET /insecure_protocol.xml
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

      if params[:sort_by] == "nmap_service_name"
        @sort_by = "nmap_service_name"
      end

      if params[:sort_by] == "test_area_name"
        @sort_by = "test_area_name"
      end

      if params[:sort_by] == "port"
        @sort_by = "port"
      end

      if params[:sort_by] == "transport_protocol"
        @sort_by = "transport_protocol"
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

   if not params[:port_v].nil?
     where[:port] = params[:port_v]
     @url_params[:port_v] = params[:port_v]
   end

   if not params[:host_id_v].nil?
     @host_menu = 1
     @host = Host.find(params[:host_id_v])
     @page_title="Insecure Protocols for #{@host.ip_address} in area #{@host.test_area_name}"
     where[:host_id] = params[:host_id_v]
     @url_params[:host_id_v] = params[:host_id_v]
   end

   if not params[:trans_v].nil?
     where[:transport_protocol] = params[:trans_v]
     @url_params[:trans_v] = params[:trans_v]
   end

  if session[:test_area].nil?
    @record_count = InsecureProtocol.find(:all, :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
    InsecureProtocol.find(:all, :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  else
    @record_count = InsecureProtocol.find_all_by_test_area_id(session[:test_area], :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
    InsecureProtocol.find_all_by_test_area_id(session[:test_area], :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  end

  @insecure_protocols = @pager.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @insecure_protocols }
    end
  end

end
