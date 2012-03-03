class PortSummarysController < ApplicationController
  require 'paginator'
  # GET /port_summary
  # GET /port_summary.xml
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

      if params[:sort_by] == "count"
        @sort_by = "count"
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
   else
     order_clause = "count desc"
   end

   if not params[:trans_v].nil?
     where[:transport_protocol] = params[:trans_v]
     @url_params[:trans_v] = params[:trans_v]
   end

  if session[:test_area].nil?
    @record_count = PortSummary.find(:all, :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      # PortSummary.find(:all, :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
      PortSummary.find(:all, :select => ["sum(count) as count, port, transport_protocol"], :order => order_clause, :limit => per_page, :offset => offset, :conditions => where, :group => "port, transport_protocol")
      # TODO order by something
    end
  else
    @record_count = PortSummary.find_all_by_test_area_id(session[:test_area], :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      PortSummary.find_all_by_test_area_id(session[:test_area], :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
      # TODO order by something
    end
  end

  @port_summarys = @pager.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @port_summarys }
    end
  end

  # GET /port_summary/1
  # GET /port_summary/1.xml
  def show
    @port_info = PortSummary.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @port_info }
    end
  end

end
