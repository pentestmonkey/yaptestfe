class PortInfo < ActiveRecord::Base
	belongs_to :port
	# belongs_to :port_key, :foreign_key => "key_id" 
	set_table_name "view_port_info"
end
