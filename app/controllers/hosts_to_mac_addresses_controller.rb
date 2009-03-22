class HostsToMacAddressesController < ApplicationController
  require 'paginator'
  # GET /hosts_to_mac_addresses
  # GET /hosts_to_mac_addresses.xml
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

      if params[:sort_by] == "mac_address"
        @sort_by = "mac_address"
      end

      if params[:sort_by] == "mac_vendor"
        @sort_by = "mac_vendor"
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

   if not params[:mac_v].nil?
     where[:mac_address] = params[:mac_v]
     @url_params[:mac_v] = params[:mac_v]
   end

   if not params[:mac_vendor_v].nil?
     where[:mac_vendor] = params[:mac_vendor_v]
     @url_params[:mac_vendor_v] = params[:mac_vendor_v]
   end

  if session[:test_area].nil?
    @record_count = HostsToMacAddresses.find(:all, :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
    HostsToMacAddresses.find(:all, :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  else
    @record_count = HostsToMacAddresses.find_all_by_test_area_id(session[:test_area], :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
    HostsToMacAddresses.find_all_by_test_area_id(session[:test_area], :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  end

  @hosts_to_mac_addresses = @pager.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hosts }
    end
  end

  # GET /hosts_to_mac_addresses/1
  # GET /hosts_to_mac_addresses/1.xml
  def show
    @hosts_to_mac_addresses = HostsToMacAddresses.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hosts_to_mac_addresses }
    end
  end

end
