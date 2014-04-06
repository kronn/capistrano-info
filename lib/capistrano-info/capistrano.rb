Capistrano::Configuration.instance.load do
  namespace :info do
    desc <<-DESC
    Tail all or a single remote file

    The logfile can be specified with a LOGFILE-environment variable.
    It defaults to RAILS_ENV.log
    DESC
    task :tail, :roles => :app do
      ENV["LOGFILE"] ||= "#{fetch(:rails_env, 'production')}.log"
      begin
        stream "tail -f #{shared_path}/log/#{ENV["LOGFILE"]}"
      rescue Interrupt
        puts "\n--interrupted by user--"
        puts ""
      end
    end

    desc "Display the currently deployed Application, Revision and Release"
    task :version, :roles => :app, :except => { :no_release => true } do
      rev = current_revision
      rel = current_release.split('/').pop
      rel_date = Time.local(*rel.unpack("a4a2a2a2a2a2"))

      version_file = "#{current_path}/VERSION"
      version = begin
                  capture("test -r #{version_file} && cat #{version_file}").chomp
                rescue Capistrano::CommandError
                  ""
                end

      message = <<-EOT

    AppName: #{fetch(:application)}
    Version: #{rev}
    Release: #{rel}

    Deploy:  #{rel_date}
      EOT

      message << <<-EOT if version != ""
    Version: #{version}
      EOT

      message << <<-EOT

      EOT

      puts message
    end

    desc "Display the uname"
    task :uname do
      run "uname -a"
    end
  end
end
