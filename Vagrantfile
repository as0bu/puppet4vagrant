
$num_agents=3
$agent_gui=false
$agent_memory='1024'
$agent_cpus='1'
$base_network='192.168.11'

Vagrant.configure(2) do |config|

# Global Configuration
  config.vm.box = "puppetlabs/centos-6.6-64-nocm"

# Master Configuration
  config.vm.define "master" do |master_config|
    
    master_config.r10k.puppet_dir = "environments/production"
    master_config.r10k.puppetfile_path = "environments/production/Puppetfile"
    master_config.r10k.module_path = "environments/production/modules" 
  
    master_config.vm.host_name = "master"

    master_config.vm.provider :virtualbox do |vb|
        vb.gui = false
        vb.memory = '4096'
        vb.cpus = '2'
    end   

    master_config.vm.network "private_network", ip: $base_network+".10"

    master_config.vm.provision :shell, :path => './scripts/centos/install_puppetserver_centos.sh'
    
    master_config.vm.provision "puppet" do |puppet|
      puppet.environment = "production"
      puppet.environment_path = "environments"
      puppet.manifests_path = "./environments/production/manifests"
      puppet.manifest_file = "puppetmaster.pp"
    end
    
    master_config.vm.provision "puppet_server" do |puppet|
      puppet.puppet_server = "master"
      puppet.options = "-t"
    end

  end #End Master Configuration

# Create Agents  
  (1..$num_agents).each do |i|
    config.vm.define vm_name = "agent%02d" % i do |agent_config|
      agent_config.vm.hostname = vm_name

      ["vmware_fusion", "vmware_workstation"].each do |vmware|
        agent_config.vm.provider vmware do |v|
          v.gui = $agent_gui
          v.vmx['memsize'] = $agent_memory
          v.vmx['numvcpus'] = $agent_cpus
        end
      end

      agent_config.vm.provider :virtualbox do |vb|
        vb.gui = $agent_gui
        vb.memory = $agent_memory
        vb.cpus = $agent_cpus
      end

      ip = $base_network+".#{i+100}"
      agent_config.vm.network :private_network, ip: ip

      agent_config.vm.provision :shell, :path => './scripts/centos/install_puppet_centos.sh'
      
      agent_config.vm.provision "puppet_server" do |puppet|
        puppet.puppet_server = "master"
        puppet.options = "-t"
      end
      
    end
  end # End Agents' Configuration
end
