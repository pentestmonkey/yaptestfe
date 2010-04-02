class HelpController < ApplicationController
  # GET /help
  # GET /help.xml
  def index 
  svn = "$Revision$".gsub(/[^0-9]/, "")
  @yaptestfe_version="1.1-rc4"
  if not svn =~ /^\s*$/
  	@yaptestfe_version = @yaptestfe_version + "-svn-" + svn
  end
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
  svn = "$Revision$".gsub(/[^0-9]/, "")
  @yaptestfe_version="1.1-rc4"
  if not svn =~ /^\s*$/
  	@yaptestfe_version = @yaptestfe_version + "-svn-" + svn
  end
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def test
  require 'rubygems'
  require 'gruff'


# TODO include totals on chart
  g = Gruff::Pie.new
  g.title = "DES Hashes"
  g.data 'Cracked (100)', 100, "red"
  g.data 'Uncracked (200)', 200, "green"
  send_data(g.to_blob(fileformat='PNG'), :type     => "image/png",
                                          :disposition => 'inline')

  end
end
