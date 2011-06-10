# just call unicorn::instance and pass rails => true
define unicorn::instance::rails(
  $basedir,
  $worker_processes = 4,
  $socket_path = nil,
  $socket_backlog = 64,
  $port = nil,
  $tcp_nopush = true,
  $timeout = 60,
  $preload_app = true,
  $rolling_restarts = true,
  $rolling_restarts_sleep = 1,
  $debug_base_port = nil,
  $after_fork_extras = nil,
  $command = 'unicorn',
  $env = 'production',
  $uid = 'root',
  $gid = 'root',
  $monit_extras = nil
) {

 unicorn::instance {
   $name:
     rails                  => true,
     basedir                => $basedir,
     worker_processes       => $worker_processes,
     socket_path            => $socket_path,
     socket_backlog         => $socket_backlog,
     port                   => $port,
     tcp_nopush             => $tcp_nopush,
     timeout                => $timeout,
     preload_app            => $preload_app,
     rolling_restarts       => $rolling_restarts,
     rolling_restarts_sleep => $rolling_restarts_sleep,
     debug_base_port        => $debug_base_port,
     after_fork_extras      => $after_fork_extras,
     command                => $command,
     env                    => $env,
     uid                    => $uid,
     gid                    => $gid,
     monit_extras           => $monit_extras;
 }
}