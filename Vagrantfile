
$num_agents=3
$agent_gui=false
$agent_memory='1024'
$agent_cpus='1'

Vagrant.configure(2) do |config|

# Global Configuration
  config.vm.box = "puppetlabs/ubuntu-14.04-64-nocm"

  config.r10k.puppet_dir = "environments/production"
  config.r10k.puppetfile_path = "environments/production/Puppetfile"
  config.r10k.module_path = "environments/production/modules" 

# Master Configuration
  config.vm.define "master" do |master_config|
    master_config.vm.host_name = "master"

    master_config.vm.provider :virtualbox do |vb|
        vb.gui = false
        vb.memory = '4096'
        vb.cpus = '2'
    end   

    master_config.vm.network "private_network", ip: "192.168.11.10"

    master_config.vm.provision :shell, :path => './scripts/install_puppetserver.sh'
    
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
    config.vm.define vm_name = "agent%02d" % i do |config|
      config.vm.hostname = vm_name

      ["vmware_fusion", "vmware_workstation"].each do |vmware|
        config.vm.provider vmware do |v|
          v.gui = $agent_gui
          v.vmx['memsize'] = $agent_memory
          v.vmx['numvcpus'] = $agent_cpus
        end
      end

      config.vm.provider :virtualbox do |vb|
        vb.gui = $agent_gui
        vb.memory = $agent_memory
        vb.cpus = $agent_cpus
      end

      ip = "192.168.11.#{i+100}"
      config.vm.network :private_network, ip: ip

    end
  end # End Agents' Configuration
end