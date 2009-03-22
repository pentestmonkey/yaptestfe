class TablenController < ApplicationController
  def set
  	if not params[:id].nil? and params[:id].to_i > 0 and params[:id].to_i < 100000
		session[:tablen] = params[:id].to_i
	end
	redirect_to :back
  end
end
