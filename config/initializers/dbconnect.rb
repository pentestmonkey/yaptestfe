        ActiveRecord::Base.establish_connection(
          :adapter  => ENV['YAPTESTFE_DBTYPE'],
          :host     => ENV['YAPTESTFE_DBIP'],
          :port     => ENV['YAPTESTFE_DBPORT'].to_i,
          :username => ENV['YAPTESTFE_DBUSER'],
          :password => ENV['YAPTESTFE_DBPASS'],
          :database => ENV['YAPTESTFE_DBNAME']
        )  
