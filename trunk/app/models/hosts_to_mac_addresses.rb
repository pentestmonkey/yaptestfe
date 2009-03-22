class HostsToMacAddresses < ActiveRecord::Base
	belongs_to :host
	set_table_name "view_mac_addresses"
end
