class TopologysController < ApplicationController
  def index

  if session[:test_area].nil?
    @topologies = Topology.find(:all)
  else
    @topologies = Topology.find_all_by_test_area_id(session[:test_area])
  end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topologies }
    end
  end



  def graph

	require 'rgl/adjacency'
	require 'rgl/dot'
	require 'tempfile'
	dg=RGL::AdjacencyGraph[]
	hop_ips = {}
	
	  if session[:test_area].nil?
	    @topologies = Topology.find(:all)
	  else
	    @topologies = Topology.find_all_by_test_area_id(session[:test_area])
	  end

	for topology in @topologies
		ip = topology.ip_address
		if not topology.prev_hop_number.nil?
			if hop_ips[topology.prev_hop_number].nil?
				hop_ips[topology.prev_hop_number] = []
			end
			hop_ips[topology.prev_hop_number].push(diag_name_of(topology.prev_hop_ip).gsub('\n', '\\\\\\\\n'))
		end
		if not topology.hop_number.nil?
			if hop_ips[topology.hop_number].nil?
				hop_ips[topology.hop_number] = []
			end
			hop_ips[topology.hop_number].push(diag_name_of(topology.ip_address).gsub('\n', '\\\\\\\\n'))
		end
		prev_ip = topology.prev_hop_ip
	
		ip_name = diag_name_of(ip)
		prev_ip_name = diag_name_of(prev_ip)
	
		if not ip_name == prev_ip_name
			if not dg.has_edge?(prev_ip_name, ip_name) and not dg.has_edge?(ip_name, prev_ip_name)
				dg.add_edge prev_ip_name, ip_name
			end
		end
	end
	
	headstring = '
	graph RGL__AdjacencyGraph {
		graph [
			rankdir = "TB"
		];
	
	        edge [style=invis];
		node [fontsize=20, shape=none];
	
	'
	
	headstring = headstring + "\t\"hop0" + '" [ fontsize = 8, label = "" ]' + "\n"
	for hop in 1..20
		headstring = headstring + "\thop#{hop - 1} -- hop#{hop}\n"
		headstring = headstring + "\t\"hop#{hop}" + '" [ fontsize = 8, label = "" ]' + "\n"
	end
	
	headstring = headstring + '
		edge [style=filled];
		node [fontsize=20, shape=ellipse];
	'
	
	rankstring = ''
	hop_ips.keys.each{|key|
		rankstring = rankstring + "{ rank=same; hop#{key} "
		hop_ips[key].uniq.each{|ip|
			rankstring = rankstring + "\"#{ip}\" "
		}
		rankstring = rankstring + ";}\n"
	}
	
	picfile = Tempfile.new('graphpic')
	dotfile = Tempfile.new('graphdot')
	
	File.open(dotfile.path, "w") do |f|
		f << dg.to_dot_graph.to_s.sub("subgraph RGL__AdjacencyGraph {", headstring).chop + rankstring + "}\n"
	end
	dotfile.close
	
	system( "dot -Tgif #{dotfile.path} -o #{picfile.path}" )
	
	picblob = File.open(picfile.path, "rb") {|io| io.read }
	File.delete(picfile.path)
	File.delete(dotfile.path)
	send_data(picblob, :type => "image/gif", :disposition => 'inline')
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

end
