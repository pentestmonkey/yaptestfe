class PortsController < ApplicationController
  require 'paginator'
  # GET /ports
  # GET /ports.xml
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
     where[:host_id] = params[:host_id_v]
     @url_params[:host_id_v] = params[:host_id_v]
   end

   if not params[:trans_v].nil?
     where[:transport_protocol] = params[:trans_v]
     @url_params[:trans_v] = params[:trans_v]
   end

  if session[:test_area].nil?
    @record_count = Port.find(:all, :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      Port.find(:all, :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  else
    @record_count = Port.find_all_by_test_area_id(session[:test_area], :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      Port.find_all_by_test_area_id(session[:test_area], :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  end

  @ports = @pager.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ports }
    end
  end

  # GET /ports/1
  # GET /ports/1.xml
  def show
    @port = Port.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @port }
    end
  end

end
