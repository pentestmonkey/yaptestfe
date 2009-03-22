class Port < ActiveRecord::Base
	belongs_to :host
	set_primary_key "port_id"
	set_table_name "view_ports"
end
