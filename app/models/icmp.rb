class Icmp < ActiveRecord::Base
	belongs_to :host
	set_table_name "view_icmp"
end
