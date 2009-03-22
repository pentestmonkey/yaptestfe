class Issue < ActiveRecord::Base
	belongs_to :port
	set_table_name "view_issues"
end
