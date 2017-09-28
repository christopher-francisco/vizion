######################################################################################################
# Helper functions
######################################################################################################

def step(description)
  description = "-- #{description} "
  description = description.ljust(80, '-')
  puts
  puts "\e[32m#{description}\e[0m"
end

def brew_install(formula)
  sh "brew install #{formula}"
end

def brew_cask_install(formula)
    sh "brew cask install #{formula}"
end

def link_file(original, symlink)
  if File.exists?(symlink) || File.symlink?(symlink)
    puts "Unable to link #{symlink}, a file or a symlink already exist with the same name."
  else
    ln_s original, symlink, :verbose => true
  end
end

def unlink_file(symlink)
  if File.symlink?(symlink)
    rm_f symlink, :verbose => true
  else
    puts "Unable to unlink #{symlink}, the file doesn't exist or is not a symlink."
  end
end


######################################################################################################
# Installation
######################################################################################################

namespace :test do
  desc 'Test brew_install'
  task :brew_install do
    step 'wget'
    brew_install 'wget'
  end

  task :brew_cask_install do
    step 'atom'
    brew_cask_install 'atom'
  end

  task :all => [:brew_install, :brew_cask_install]
end

namespace :install do

  desc 'Install xcode tools'
  task :xcode_select do
    puts 'Installing xcode tools. Please accept the prompt'
    sh "xcode-select --install"
  end

  desc 'Install brew'
  task :brew do
  end

  desc 'Install oh my zsh'
  task :oh_my_zsh do
    sh 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
  end

  task :all => [
    :xcode_select,
    :brew,
  ]
end


task :default => 'install:all'
task :test => 'test:all'
