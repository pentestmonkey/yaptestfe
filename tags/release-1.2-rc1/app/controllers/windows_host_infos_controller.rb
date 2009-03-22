class WindowsHostInfosController < ApplicationController
  require 'paginator'
  # GET /windows_host_infos
  # GET /windows_host_infos.xml
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

    if not params[:test_area_name_v].nil?
      where[:test_area_name] = params[:test_area_name_v]
      @url_params[:test_area_name_v] = params[:test_area_name_v]
    end

    if not params[:ip_address_v].nil?
      where[:ip_address] = params[:ip_address_v]
      @url_params[:ip_address_v] = params[:ip_address_v]
    end

    if not params[:os_v].nil?
      where[:os] = params[:os_v]
      @url_params[:os_v] = params[:os_v]
    end

    if not params[:dom_name_v].nil?
      where[:dom_name] = params[:dom_name_v]
      @url_params[:dom_name_v] = params[:dom_name_v]
    end

    if not params[:dc_v].nil?
      where[:dc] = params[:dc_v]
      @url_params[:dc_v] = params[:dc_v]
    end

    if not params[:member_of_v].nil?
      where[:member_of] = params[:member_of_v]
      @url_params[:member_of_v] = params[:member_of_v]
    end

    if not params[:smb_server_version_v].nil?
      where[:smb_server_version] = params[:smb_server_version_v]
      @url_params[:smb_server_version_v] = params[:smb_server_version_v]
    end

    if not params[:domain_sid_v].nil?
      where[:domain_sid] = params[:domain_sid_v]
      @url_params[:domain_sid_v] = params[:domain_sid_v]
    end

    if not params[:pwd_complexity_flags_v].nil?
      where[:pwd_complexity_flags] = params[:pwd_complexity_flags_v]
      @url_params[:pwd_complexity_flags_v] = params[:pwd_complexity_flags_v]
    end

    if not params[:lockout_threshold_v].nil?
      where[:lockout_threshold] = params[:lockout_threshold_v]
      @url_params[:lockout_threshold_v] = params[:lockout_threshold_v]
    end

    if not params[:lockout_duration_v].nil?
      where[:lockout_duration] = params[:lockout_duration_v]
      @url_params[:lockout_duration_v] = params[:lockout_duration_v]
    end

    if not params[:reset_lockout_ctr_v].nil?
      where[:reset_lockout_ctr] = params[:reset_lockout_ctr_v]
      @url_params[:reset_lockout_ctr_v] = params[:reset_lockout_ctr_v]
    end

    if not params[:sort_by].nil?

      if params[:sort_by] == "ip_address"
        @sort_by = "ip_address"
      end

      if params[:sort_by] == "test_area_name"
        @sort_by = "test_area_name"
      end

      if params[:sort_by] == "hostname"
        @sort_by = "hostname"
      end

      if params[:sort_by] == "os"
        @sort_by = "os"
      end

      if params[:sort_by] == "dom_name"
        @sort_by = "dom_name"
      end

      if params[:sort_by] == "dc"
        @sort_by = "dc"
      end

      if params[:sort_by] == "member_of"
        @sort_by = "member_of"
      end

      if params[:sort_by] == "smb_server_version"
        @sort_by = "smb_server_version"
      end

      if params[:sort_by] == "domain_sid"
        @sort_by = "domain_sid"
      end

      if params[:sort_by] == "pwd_complexity_flags"
        @sort_by = "pwd_complexity_flags"
      end

      if params[:sort_by] == "lockout_threshold"
        @sort_by = "lockout_threshold"
      end

      if params[:sort_by] == "lockout_duration"
        @sort_by = "lockout_duration"
      end

      if params[:sort_by] == "reset_lockout_ctr"
        @sort_by = "reset_lockout_ctr"
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

   if not params[:test_area_name_v].nil?
     where[:test_area_name] = params[:test_area_name_v]
     @url_params[:test_area_name_v] = params[:test_area_name_v]
   end

   if not params[:ip_address_v].nil?
     where[:ip_address] = params[:ip_address_v]
     @url_params[:ip_address_v] = params[:ip_address_v]
   end

   if not params[:hostname_v].nil?
     where[:hostname] = params[:hostname_v]
     @url_params[:hostname_v] = params[:hostname_v]
   end

   if not params[:os_v].nil?
     where[:os] = params[:os_v]
     @url_params[:os_v] = params[:os_v]
   end

   if not params[:dom_name_v].nil?
     where[:dom_name] = params[:dom_name_v]
     @url_params[:dom_name_v] = params[:dom_name_v]
   end

   if not params[:dc_v].nil?
     where[:dc] = params[:dc_v]
     @url_params[:dc_v] = params[:dc_v]
   end

   if not params[:smb_server_version_v].nil?
     where[:smb_server_version] = params[:smb_server_version_v]
     @url_params[:smb_server_version_v] = params[:smb_server_version_v]
   end

   if not params[:domain_sid_v].nil?
     where[:domain_sid] = params[:domain_sid_v]
     @url_params[:domain_sid_v] = params[:domain_sid_v]
   end

   if not params[:pwd_complexity_flags_v].nil?
     where[:pwd_complexity_flags] = params[:pwd_complexity_flags_v]
     @url_params[:pwd_complexity_flags_v] = params[:pwd_complexity_flags_v]
   end

   if not params[:lockout_threshold_v].nil?
     where[:lockout_threshold] = params[:lockout_threshold_v]
     @url_params[:lockout_threshold_v] = params[:lockout_threshold_v]
   end

   if not params[:lockout_duration_v].nil?
     where[:lockout_duration] = params[:lockout_duration_v]
     @url_params[:lockout_duration_v] = params[:lockout_duration_v]
   end

   if not params[:reset_lockout_ctr_v].nil?
     where[:reset_lockout_ctr] = params[:reset_lockout_ctr_v]
     @url_params[:reset_lockout_ctr_v] = params[:reset_lockout_ctr_v]
   end

  if session[:test_area].nil?
    @record_count = WindowsHostInfo.find(:all, :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
    WindowsHostInfo.find(:all, :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  else
    @record_count = WindowsHostInfo.find_all_by_test_area_id(session[:test_area], :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
    WindowsHostInfo.find_all_by_test_area_id(session[:test_area], :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  end

  @windows_host_infos = @pager.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @windows_host_infos }
    end
  end

end
