# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

# DB selection code based on:
# http://wiki.rubyonrails.org/rails/pages/HowtoUseMultipleDatabases
class ApplicationController < ActionController::Base
  # here, we hop into the front of the request-handling
  # pipeline to run a method called hijack_db
  before_filter :hijack_db

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'b57593863c5718a3c437b4bd4ba26c8d'

  # here, we're going to manually establish a connection
  # to the database we feel like connecting to.
  def hijack_db
      ActiveRecord::Base.establish_connection(
        :adapter  => ENV['YAPTESTFE_DBTYPE'],
        :host     => ENV['YAPTESTFE_DBIP'],
        :port     => ENV['YAPTESTFE_DBPORT'].to_i,
        :username => ENV['YAPTESTFE_DBUSER'],
        :password => ENV['YAPTESTFE_DBPASS'],
        :database => ENV['YAPTESTFE_DBNAME']
      )  
      begin # catch db connection errors
      if not ActiveRecord::Base.connection.active?
        render :template => 'help/dberror', :layout => false
      end
      rescue PGError => msg
        logger.info "DBERROR: #{msg}"
        render :template => 'help/dberror', :layout => false
      end
  end
end
