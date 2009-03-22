class PasswordHashsController < ApplicationController
  require 'paginator'
  # GET /password_hash
  # GET /password_hash.xml
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

      if params[:sort_by] == "type"          # TODO broken
        @sort_by = "password_hash_type_name"
      end

      if params[:sort_by] == "username"
        @sort_by = "username"
      end

      if params[:sort_by] == "password_hash"
        @sort_by = "password_hash"
      end

      if params[:sort_by] == "password"
         @sort_by = "password"
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
     @page_title="Hashes for #{@host.ip_address} in area #{@host.test_area_name}"
     where[:host_id] = params[:host_id_v]
     @url_params[:host_id_v] = params[:host_id_v]
   end

   if not params[:port_v].nil?
     where[:port] = params[:port_v]
     @url_params[:port_v] = params[:port_v]
   end

   if not params[:trans_v].nil?
     where[:transport_protocol_name] = params[:trans_v]
     @url_params[:trans_v] = params[:trans_v]
   end

   if not params[:type_v].nil?
     where[:password_hash_type_name] = params[:type_v]
     @url_params[:type_v] = params[:type_v]
   end

   if not params[:username_v].nil?
     where[:username] = params[:username_v]
     @url_params[:username_v] = params[:username_v]
   end

   if not params[:password_v].nil?
     where[:password] = params[:password_v]
     @url_params[:password_v] = params[:password_v]
   end

   if not params[:hash_v].nil?
     where[:password_hash] = params[:hash_v]
     @url_params[:hash_v] = params[:hash_v]
   end

  if session[:test_area].nil?
    @record_count = PasswordHash.find(:all, :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
    PasswordHash.find(:all, :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  else
    @record_count = PasswordHash.find_all_by_test_area_id(session[:test_area], :conditions => where).length
    @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
    PasswordHash.find_all_by_test_area_id(session[:test_area], :order => order_clause, :limit => per_page, :offset => offset, :conditions => where)
    end
  end
  @password_hashs = @pager.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @password_hashs }
    end
  end

end
