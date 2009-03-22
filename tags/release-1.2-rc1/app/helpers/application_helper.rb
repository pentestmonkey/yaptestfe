# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def filter_icon (tool_tip, param_v, link_opts={})
	  # If we aren't currely filtering on this field, print the filter icon
	  if param_v.nil?
	    return link_to(image_tag("filter.png", :align => 'absmiddle'), link_opts.merge(@url_params).merge({ :sort_by => @sort_by, :sort_dir => @sort_dir}), {:onmouseover => "Tip('#{tool_tip}')", :onmouseout => "UnTip()"})

	  # Otherwise don't show the icon
	  else
	    return ''
	  end
	end

	def link_to_host (ip, opts={})
		return link_to(ip, opts, { :onmouseover => "Tip('More info about #{ip}')", :onmouseout => "UnTip()"})
	end

	def filterx_icon (tool_tip, param_v, key_name, link_opts={})
	  # If we aren't currely filtering on this field, print the filter icon
	  if not param_v.nil?
	    @url_parm_copy = @url_params.dup
	    @url_parm_copy.delete(key_name)
	    return link_to(image_tag("filterx.png", :align => 'absmiddle'), link_opts.merge(@url_parm_copy).merge({ :sort_by => @sort_by, :sort_dir => @sort_dir}), {:onmouseover => "Tip('#{tool_tip}')", :onmouseout => "UnTip()"})

	  # Otherwise don't show the icon
	  else
	    return ''
	  end
	end

	def www_link_icon (port_info)
		 if port_info.port_info_key == 'nmap_service_name' and port_info.value == 'http'
		 	webs = PortInfoSsl.find(:all, :conditions => { :port_id => port_info.port_id, :nmap_service_tunnel => 'ssl' } )
			for web in webs
			 	if web.nmap_service_tunnel == 'ssl'
					return  link_to(image_tag("application_link.png", :align => 'absmiddle'), "https://#{port_info.ip_address}:#{port_info.port.port}", {:onmouseover => "Tip('Open https://#{port_info.ip_address}:#{port_info.port.port} in new window')", :onmouseout => "UnTip()", :target => '_blank'})
			 	end
			end
			if webs.empty?
					return  link_to(image_tag("application_link.png", :align => 'absmiddle'), "http://#{port_info.ip_address}:#{port_info.port.port}", {:onmouseover => "Tip('Open http://#{port_info.ip_address}:#{port_info.port.port} in new window')",:onmouseout => "UnTip()", :target => '_blank'})
			end
		 end
	end

	def sort_icon (sort_param_name)
		if @sort_by == sort_param_name
			if @sort_dir == "desc"
				return image_tag("sort_desc.png", :align => 'absmiddle', :onmouseover => "Tip('Sorting by #{sort_param_name} descending')", :onmouseout => "UnTip()")
			else
				return image_tag("sort_asc.png", :align => 'absmiddle', :onmouseover => "Tip('Sorting by #{sort_param_name} ascending')", :onmouseout => "UnTip()")
			end
		end
		return ''
	end

	def diag_name_of (ip)
		b = Interface.find_by_ip_address(ip)
		ifaces = Interface.find_all_by_box_id(b.box_id, :order => "ip_address")
		diag_name = nil
		for iface in ifaces
			if diag_name.nil?
				diag_name = iface.ip_address
			else
				diag_name = diag_name + '\n' + iface.ip_address
			end
		end
		return diag_name
	end

        def yt_truncate (text, length = 30, truncate_string = "...")
                if text.nil? then return end
                l = length - truncate_string.length
                (text.length > length ? text[0...l] + truncate_string :text).to_s 
	end

	def sort_link (link_text, sort_param_name)
		new_sort_dir = "asc"
		sort_description = "ascending"
		sort_hash = {}

		if sort_param_name == @sort_by
			if @sort_dir == "asc"
				new_sort_dir = "desc"
				sort_description = "descending"
			end
		end

		if sort_param_name == "session_test_area"
			sort_param_name = "test_area_name"
			if @sort_dir == "asc"
				new_sort_dir = "desc"
				sort_description = "descending"
			end
		end

		sort_hash[:sort_by] = sort_param_name
		sort_hash[:sort_dir] = new_sort_dir

 		return link_to(link_text, {:controller => @cont, :action => @action}.merge(sort_hash).merge(@url_params), {:onmouseover => "Tip('Sort by #{sort_param_name} #{sort_description}')", :onmouseout => "UnTip()"}) << sort_icon(sort_param_name)

		# :action => @action}.merge(@url_parm_copy).merge(sort_hash)
	end
end
