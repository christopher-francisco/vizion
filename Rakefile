require_relative 'installer.rb'
require_relative 'linker.rb'
require_relative 'logger.rb'

logger = Logger.new
installer = Installer.new
linker = Linker.new

def lines_from_file(file)
  return File::readlines(file).map { |line| line.chomp } # We want to remove the "\n"
end

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

  desc 'Install brew packages'
  task :brew_packages do
    installer.shell 'brew bundle install', true
    logger.write "Brew packages installed"
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
  
  desc 'Link oh-my-zsh Themes'
  task :oh_my_zsh_themes do
    logger.step 'oh-my-zsh', 'Linking oh-my-zsh themes'

    themesDir = "#{Dir.home}/.oh-my-zsh/custom/themes"
    themes = Dir.glob 'oh-my-zsh-themes/**/*.zsh-theme', File::FNM_DOTMATCH

    FileUtils.mkdir_p themesDir

    logger.oh_my_zsh_theme_count themes.count

    themes.each do |themePath|
      theme = File.basename(themePath)

      if linker.link "#{Dir.pwd}/#{themePath}", "#{themesDir}/#{theme}"
        logger.oh_my_zsh_theme_linked theme
      else
        logger.oh_my_zsh_theme_not_linked theme
      end
    end
  end

  desc 'Sets up iTerm2 profile'
  task :iterm2_profile do
    logger.step 'iTerm2', 'Setting iTerm2 profile'

    installer.sh 'defaults write com.googlecode.iterm2.plist NoSyncNeverRemindPrefsChangesLostForFile_selection -int 0'
    installer.sh 'defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true'
    installer.sh 'defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.iterm2"'
    logger.iterm2_configured
  end

  desc 'Set up visuals'
  task :visuals do
    logger.step 'Visuals', 'Setting up visuals'

    installer.sh 'tic -x ~/.iterm2/files/xterm-256color-italic.terminfo'
    installer.sh 'tic -x ~/.iterm2/files/tmux-256color.terminfo'
    logger.true_colors_and_italics_configured
  end

  desc 'Grip settings'
  task :grip_settings do
    installer.shell './scripts/setup_grip.sh', true
    logger.write "Grip settings configured"
  end

  desc 'Gitconfig local setup'
  task :gitconfig_local_setup do
    installer.shell './scripts/setup_gitconfig.sh local', true
    logger.write "Gitconfig local configured"
  end

  desc 'Setup github tokens and rhubarb'
  task :github_tokens_and_rhubarb do
    installer.shell './scripts/setup_tokens.sh', true
    installer.shell './scripts/setup-rhubarb.sh', true
    logger.write "Gitconfig local configured"
  end

  desc 'Setup SSH keys'
  task :setup_ssh_keys do
    installer.shell './scripts/setup_ssh_keys.sh', true
    logger.write "SSH keys configured"
  end

  desc 'End step'
  task :end do
    logger.blank_line
    logger.vizion_ended
  end

  task :all => [
    :start,
    :base,
    :brew_packages,
    :yarn_packages,
    :dotfiles,
    :directories,
    :oh_my_zsh_themes,
    :tmux_plugin_manager,
    :tmux_plugins,
    :vim_plugs,
    :iterm2_profile,
    :visuals,
    :grip_settings,
    :gitconfig_local_setup,
    :setup_ssh_keys,
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

  desc 'directories'
  task :directories do
    logger.write('Unlinking directories')
    directories = Dir.children('./directories')

    directories.each do |dirname|
      unless linker.unlink("#{Dir.home}/#{dirname}")
        logger.write("Unable to unlink #{dirname}, it doesn't exist.")
      end
    end
  end
end

task :default => 'install:all'
task :test => 'test:all'
