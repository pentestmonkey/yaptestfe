class HostsController < ApplicationController
  require 'paginator'
  # GET /hosts
  # GET /hosts.xml
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

    if not params[:name_type_v].nil?
      where[:name_type] = params[:name_type_v]
      @url_params[:name_type_v] = params[:name_type_v]
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

      if params[:sort_by] == "name_type"
        @sort_by = "name_type"
      end

      if params[:sort_by] == "hostname"
        @sort_by = "hostname"
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

  if session[:test_area].nil?
    @record_count = Host.find(:all, :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      Host.find(:all, :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  else
    @record_count = Host.find_all_by_test_area_id(session[:test_area], :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      Host.find_all_by_test_area_id(session[:test_area], :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  end
  @hosts= @pager.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hosts }
    end
  end

  # ???
  def showports
   @sort_by = nil
   @sort_dir = nil
   order_clause = nil

    if not params[:sort_by].nil?

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

    @record_count = Port.find_all_by_host_id(params[:id]).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      Port.find_all_by_host_id(params[:id], :order => order_clause, :limit => per_page, :offset => offset)
    end
    @ports= @pager.page(params[:page])
    @host = Host.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @host }
    end
  end

  def showportinfo
   @sort_by = nil
   @sort_dir = nil
   order_clause = nil

    if not params[:sort_by].nil?


      if params[:sort_by] == "port"
        @sort_by = "port"
      end

      if params[:sort_by] == "transport_protocol"
        @sort_by = "transport_protocol"
      end

      if params[:sort_by] == "ip_address"
        @sort_by = "ip_address"
      end

      if params[:sort_by] == "test_area_name"
        @sort_by = "test_area_name"
      end

      if params[:sort_by] == "key"
        @sort_by = "port_info_key"
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
    @record_count = PortInfo.find_all_by_host_id(params[:id]).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
       PortInfo.find_all_by_host_id(params[:id], :order => order_clause, :limit => per_page, :offset => offset)
    end
    @port_info = @pager.page(params[:page])
    @host = Host.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @host }
    end
  end

  def showhostinfo
   @sort_by = nil
   @sort_dir = nil
   order_clause = nil

    if not params[:sort_by].nil?

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
    @record_count = HostInfo.find_all_by_host_id(params[:id]).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      HostInfo.find_all_by_host_id(params[:id], :order => order_clause, :limit => per_page, :offset => offset)
    end

    @host = Host.find(params[:id])
    @host_info = @pager.page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @host }
    end
  end

  def showicmp
   @sort_by = nil
   @sort_dir = nil
   order_clause = nil

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
    @record_count = Icmp.find_all_by_host_id(params[:id]).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      Icmp.find_all_by_host_id(params[:id], :order => order_clause, :limit => per_page, :offset => offset)
    end

    @host = Host.find(params[:id])
    @icmps = @pager.page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @host }
    end
  end

  def showinsecprotos
   @sort_by = nil
   @sort_dir = nil
   order_clause = nil

    if not params[:sort_by].nil?

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
    @record_count = InsecureProtocol.find_all_by_host_id(params[:id]).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      InsecureProtocol.find_all_by_host_id(params[:id], :order => order_clause, :limit => per_page, :offset => offset)
    end

    @host = Host.find(params[:id])
    @insec_protos = @pager.page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @host }
    end
  end

  # ???
  def showcreds
   @sort_by = nil
   @sort_dir = nil
   order_clause = nil

    if not params[:sort_by].nil?

      if params[:sort_by] == "credential_type_name"
        @sort_by = "credential_type_name"
      end

      if params[:sort_by] == "domain"
        @sort_by = "domain"
      end

      if params[:sort_by] == "port"
        @sort_by = "port"
      end

      if params[:sort_by] == "username"
        @sort_by = "username"
      end

      if params[:sort_by] == "password"
        @sort_by = "password"
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
    @record_count = Credential.find_all_by_host_id(params[:id]).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      Credential.find_all_by_host_id(params[:id], :order => order_clause, :limit => per_page, :offset => offset)
    end

    @host = Host.find(params[:id])
    @credentials = @pager.page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @host }
    end
  end

  def showgroups
   @sort_by = nil
   @sort_dir = nil
   order_clause = nil

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
    @record_count = Group.find_all_by_group_host_id(params[:id]).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      Group.find_all_by_group_host_id(params[:id], :order => order_clause, :limit => per_page, :offset => offset)
    end

    @host = Host.find(params[:id])
    @groups = @pager.page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @host }
    end
  end

  def showpasswordhashes
   @sort_by = nil
   @sort_dir = nil
   order_clause = nil

    if not params[:sort_by].nil?

      if params[:sort_by] == "password_hash_type_name"
        @sort_by = "password_hash_type_name"
      end

      if params[:sort_by] == "username"
        @sort_by = "username"
      end

      if params[:sort_by] == "password"
        @sort_by = "password"
      end

      if params[:sort_by] == "password_hash"
        @sort_by = "password_hash"
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
    @record_count = Credential.find_all_by_host_id(params[:id]).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      Credential.find_all_by_host_id(params[:id], :order => order_clause, :limit => per_page, :offset => offset)
    end

    @host = Host.find(params[:id])
    @password_hashes = @pager.page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @host }
    end
  end

  # ???
  def showissues
   @sort_by = nil
   @sort_dir = nil
   order_clause = nil

    if not params[:sort_by].nil?

      if params[:sort_by] == "port"
        @sort_by = "port"
      end

      if params[:sort_by] == "transport_protocol_name"
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
    @record_count = Issue.find_all_by_host_id(params[:id]).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
      Issue.find_all_by_host_id(params[:id], :order => order_clause, :limit => per_page, :offset => offset)
    end

    @host = Host.find(params[:id])
    @issues = @pager.page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @host }
    end
  end

  def shownessus
    @nessusreport = HostInfo.find(:all, :conditions => { :host_id => params[:id], :key => 'nessus_html_report' })
    @host = Host.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hostinfo }
    end
  end
  def showopenvas
    @openvasreport = HostInfo.find(:all, :conditions => { :host_id => params[:id], :key => 'openvas_html_report' })
    @host = Host.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hostinfo }
    end
  end
end


