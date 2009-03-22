class Group < ActiveRecord::Base
	belongs_to :port
	belongs_to :host
	set_table_name :view_groups
end
