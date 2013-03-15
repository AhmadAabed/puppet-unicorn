define unicorn::instance(
  $basedir,
  $worker_processes = 4,
  $socket_path = false,
  $socket_backlog = 64,
  $port = false,
  $tcp_nopush = true,
  $timeout_secs = 60,
  $preload_app = true,
  $rails = false,
  $rolling_restarts = true,
  $rolling_restarts_sleep = 1,
  $debug_base_port = false,
  $require_extras = [],
  $before_exec = [],
  $before_fork_extras = [],
  $after_fork_extras = [],
  $command = 'unicorn',
  $env = 'production',
  $uid = 'root',
  $gid = 'root',
  $monit_extras = ''
) {

  $real_command = $rails ? {
    true  => "${command}_rails",
    false => $command
  }

  file {
    "${name}_unicorn.conf":
      path    => "${basedir}/config/unicorn.conf.rb",
      mode    => 644,
      owner   => $uid,
      group   => $gid,
      content => template('unicorn/unicorn.conf.erb');
  }

  $process_name = $name
  if $::use_monit {
    $check_socket = $socket_path ? {
      false   => '',
      default => "if failed unixsocket ${socket_path} then restart"
    }

    $check_port = $port ? {
      false   => '',
      default => "if failed host localhost port ${port}\n    protocol HTTP request \"/monit_test\"\n    with timeout ${timeout_secs}\n    then restart"
    }

   
  }
  
  else {

# Configuring component service
	supervisor::service{"salamweb":
		ensure  => present,
		enable  => true,
		command => "$real_command -E $env -c $basedir/config/unicorn.conf.rb", 
		directory => "/var/www/salamworld",
		user	=> "salamweb",
		group  	=> "salamweb",
		require => Rvm_system_ruby['ruby-1.9.3-p392'],
    }
  }
}
