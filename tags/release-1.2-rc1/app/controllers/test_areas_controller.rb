class TestAreasController < ApplicationController
  require 'paginator'
  # GET /test_areas
  # GET /test_areas.xml
  def index

   @sort_by = nil
   @sort_dir = nil
   order_clause = nil
   if session[:tablen].nil?
	session[:tablen] = 20
   end

    if not params[:sort_by].nil?

      if params[:sort_by] == "test_area_name"
        @sort_by = "name"
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

  @record_count = TestArea.count
  @pager = Paginator.new(@record_count, session[:tablen]) do |offset, per_page|
    TestArea.find(:all, :order => order_clause, :limit => per_page, :offset => offset)
  end
  @test_areas = @pager.page(params[:page])
    # TODO: order by hosts.ip_address, port

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ports }
    end
  end

  # GET /test_areas/1/set
  def set
    if params[:id] == 'all'
      session[:test_area] = nil
    else
      @test_areas = TestArea.find(params[:id])
      session[:test_area] = @test_areas.id
    end

    redirect_to :back
  end
  
  # GET /test_areas/1
  # GET /test_areas/1.xml
  def show
    @test_area = TestArea.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @test_area }
    end
  end

end
