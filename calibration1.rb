defProperty('rxnodes', 'node1-20', "rxnodes")

# Run application for receiver
defGroup('Receive', "#{property.rxnodes.to_s}") { |n|
}

# Create arrays for values we are looping over
freq_array = [500000000, 1000000000, 2000000000, 3000000000]
gain_array = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90]
amplitude_array = [-100, -90, -80, -70, -60, -50, -40, -30, -20, -10, 0]

onEvent(:ALL_UP_AND_INSTALLED) { |event|

  group("Receive").startApplications
  wait 5
  
  consoleHttp("http://instrument1.orbit-lab.org:5054/interference/initialize")

  # Loop over different frequencies
  freq_array.each { |f|
    gain_array.each { |g|
      amplitude_array.each { |a|
        info "Set ESG configuration"
        consoleHttp("http://instrument1.orbit-lab.org:5054/interference/set?frequency=#{f}\&power=#{a}")
	consoleHttp("http://instrument1.orbit-lab.org:5054/interference/start")
        wait 2
        group("Receive").exec("/usr/bin/wiserd --uhd_rx_freq #{f} --uhd_rx_gain #{g} --recv_numbins 256 --recv_oml_servername file --recv_oml_filename power_grid_#{f}_#{g}_#{a}.dat --recv_running_time 2000 --addmodule fftsigpoweroml --timed
")
        wait 10
        group("Receive").exec("/usr/bin/pkill -9 wiserd")
      }
    wait 2
    }
  wait 20
  }
  allGroups.stopApplications
  Experiment.done
  exit
}


