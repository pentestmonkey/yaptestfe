class NmapInfo < ActiveRecord::Base
	belongs_to :port
	# belongs_to :port_key, :foreign_key => "key_id" 
	set_table_name "view_nmap_info"
end
