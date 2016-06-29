set :rvm_path, '$HOME/.rvm/scripts/rvm'

task :'rvm:use', :env do |_, args|
  unless args[:env]
    print_error "Task 'rvm:use' needs an RVM environment name as an argument."
    print_error "Example: invoke :'rvm:use[ruby-1.9.2@default]'"
    die
  end

  comment "Using RVM environment '#{args[:env]}'"
  command %(
    if [[ ! -s "#{fetch(:rvm_path)}" ]]; then
      echo "! Ruby Version Manager not found"
      echo "! If RVM is installed, check your :rvm_path setting."
      exit 1
    fi
  )
  command "source #{fetch(:rvm_path)}"
  command "rvm use '#{args[:env]}' --create"
end

task :'rvm:wrapper', :env, :name, :bin do |_, args|
  unless args[:env] && args[:name] && args[:bin]
    print_error "Task 'rvm:wrapper' needs an RVM environment name, an wrapper name and the binary name as arguments"
    print_error "Example: invoke :'rvm:wrapper[ruby-1.9.2@myapp,myapp,unicorn_rails]'"
    die
  end

  comment "creating RVM wrapper '#{args[:name]}_#{args[:bin]}' using '#{args[:env]}'"
  command %(
    if [[ ! -s "#{fetch(:rvm_path)}" ]]; then
      echo "! Ruby Version Manager not found"
      echo "! If RVM is installed, check your :rvm_path setting."
      exit 1
    fi
  )
  command "source #{fetch(:rvm_path)}"
  command "rvm wrapper #{args[:env]} #{args[:name]} #{args[:bin]} || exit 1"
end