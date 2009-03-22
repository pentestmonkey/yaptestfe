class WindowsHostInfo < ActiveRecord::Base
	belongs_to :host
	belongs_to :host_key
	set_table_name "view_windows_host_info"
end
