require_relative 'installer.rb'
require_relative 'linker.rb'
require_relative 'logger.rb'

logger = Logger.new
installer = Installer.new
linker = Linker.new

def lines_from_file(file)
  return File::readlines(file).map { |line| line.chomp } # We want to remove the "\n"
end

brew_taps = lines_from_file('./definitions/brew_taps')
brew_formulas = lines_from_file('./definitions/brew_formulas')
brew_cask_formulas = lines_from_file('./definitions/brew_cask_formulas')
yarn_packages = lines_from_file('./definitions/yarn_packages')

namespace :install do
  desc 'Start step'
  task :start do
    logger.vizion_started '1.0.0'
  end

  desc 'Install command line developer tools, Oh My Zshell, Brew'
  task :base do
    logger.step 'Base', 'Installing XCode developer tools, oh-my-zshell and brew'

    _, stderr, status = installer.sh 'xcode-select --install'

    if status.success?
      logger.xcode_tools_installed
    else
      if stderr.include? "already installed"
        logger.xcode_tools_skipped
      else
        logger.xcode_tools_not_installed
      end
    end

    _, stderr, status = installer.sh 'ls -a ~ | grep .oh-my-zsh'

    if status.success?
      logger.oh_my_zsh_skipped
    else
      _, stderr, status = installer.sh 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
      if status.success?
        logger.oh_my_zsh_installed
      else
        logger.oh_my_zsh_not_installed
      end
    end

    _, stderr, status = installer.sh 'which brew'

    if status.success?
      logger.brew_skipped
    else
      _, stderr, status = installer.sh '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
      if status.success?
        logger.brew_installed
      else
        logger.brew_not_installed
      end
    end
  end

  desc 'Tap brew third party repos'
  task :brew_tap do
    logger.step 'Brew Tap', 'Tapping brew taps'

    tapped_taps = `brew tap`.split

    brew_taps.each do |tap|
      if tapped_taps.include? tap
        logger.brew_tap_skipped tap
      else
        _, _, status = installer.sh "brew tap #{tap}"

        if status.success?
          logger.brew_tap_success tap
        else
          logger.brew_tap_failed tap
        end
      end
    end
  end

  desc 'Install the brew formulas skipping existing ones'
  task :brew_install do
    logger.step 'Brew', 'Installing brew formulas'

    installed_packages = `brew list`.split

    brew_formulas.each do |formula|
      if installed_packages.include? formula
        logger.brew_formula_skipped formula
      else 
        installer.brew_install formula
      end
    end
  end

  desc 'Install the brew formulas and check if the installed ones are up to date'
  task :brew_install_with_version_check do
    logger.step 'Brew', 'Installing brew formulas while checking for the versions'

    brew_formulas.each do |formula|
      installer.brew_install formula
    end
  end

  desc 'Install brew-cask formulas'
  task :brew_cask_install do
    logger.step 'Brew Cask', 'Installing brew-cask formulas'

    installed_packages = `brew cask list`.split

    brew_cask_formulas.each do |formula|
      if installed_packages.include? formula
        logger.brew_cask_formula_skipped formula
      else
        installer.brew_cask_install formula 
      end
    end
  end

  desc 'Install Yarn global packages'
  task :yarn_packages do
    logger.step 'Yarn', 'Installing Yarn global packages'

    stdout, _, status = installer.sh 'yarn global list'

    yarn_packages.each do |package|
      if stdout.include? package
        logger.yarn_package_skipped package
      else
        stdout, _, status = installer.sh "yarn global add #{package}"

        if status.success?
          logger.yarn_package_installed package
        else
          logger.yarn_package_not_installed package
        end
      end
    end
  end

  desc 'Install Tmux Plugin Manager'
  task :tmux_plugin_manager do
    logger.step 'TPM', 'Installing Tmux Plugin Manager'

    _, _, status = installer.sh 'ls ~/.tmux/plugins/tpm'

    if status.success?
      logger.tmux_plugin_manager_skipped
    else
      installer.shell('git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm')
      logger.tmux_plugin_manager_installed
    end
  end

  desc 'Install Tmux plugins'
  task :tmux_plugins do
    logger.step 'Tmux Plugins', 'Installing Tmux plugins'

    installer.sh '~/.tmux/plugins/tpm/bin/install_plugins'
    logger.tmux_plugins_installed
  end

  desc 'Install Vim plugs'
  task :vim_plugs do
    logger.step 'Vim plugs', 'Installing Vim plugs'

    installer.sh 'vim +PlugInstall +qall'
    logger.vim_plugs_installed
  end

  desc 'Link dotfiles'
  task :dotfiles do
    logger.step 'Dotfiles', 'Linking dotfiles to the home folder'

    projectDir = File.dirname(__FILE__)
    dotfiles = Dir.entries('./dotfiles').select {|f| !File.directory? f}

    logger.dotfile_count dotfiles.count

    dotfiles.each do |dotfile|
      if linker.link("#{projectDir}/dotfiles/#{dotfile}", "#{Dir.home}/#{dotfile}")
        logger.dotfile_linked dotfile
      else
        logger.dotfile_not_linked dotfile
      end
    end
  end

  desc 'Link directories'
  task :directories do
    logger.step 'Directories', 'Linking directories to the home folder'

    projectDir = File.dirname(__FILE__)
    directories = Dir.entries('./directories').select {|f| !(f =='.' || f == '..')}

    logger.directory_count directories.count

    directories.each do |directory|
      if linker.link("#{projectDir}/directories/#{directory}", "#{Dir.home}/#{directory}")
        logger.directory_linked directory
      else
        logger.directory_not_linked directory
      end
    end
  end

  desc 'Set up visuals'
  task :visuals do
    logger.step 'Visuals', 'Setting up visuals'

    installer.sh 'tic -x ~/.iterm2/files/xterm-256color-italic.terminfo'
    installer.sh 'tic -x ~/.iterm2/files/tmux-256color.terminfo'
    logger.true_colors_and_italics_configured
  end

  desc 'End step'
  task :end do
    logger.blank_line
    logger.vizion_ended
  end

  task :all => [
    :start,
    :base,
    :brew_tap,
    :brew_install,
    :brew_cask_install,
    :yarn_packages,
    :dotfiles,
    :directories,
    :tmux_plugin_manager,
    :tmux_plugins,
    :vim_plugs,
    :visuals,
    :end
  ]
end

namespace :uninstall do
  desc 'dotfiles'
  task :dotfiles do
    logger.write('Unlinking dotfiles')
    dotfiles = Dir.entries('./dotfiles').select {|f| !File.directory? f}

    dotfiles.each do |filename|
      unless linker.unlink("#{Dir.home}/#{filename}")
        logger.write("Unable to link #{filename}, it doesn't exist.")
      end
    end
  end

  # TODO: unlink directories?
end

task :default => 'install:all'
task :test => 'test:all'
