require_relative 'installer.rb'
require_relative 'linker.rb'
require_relative 'logger.rb'

logger = Logger.new
installer = Installer.new
linker = Linker.new

oh_my_zsh_install_command = 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
homebrew_install_command = '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

def lines_from_file(file)
  return File::readlines(file).map { |line| line.chomp } # We want to remove the "\n"
end

yarn_packages = lines_from_file('./definitions/yarn_packages')
cargo_packages = lines_from_file('./definitions/cargo_packages')

namespace :install do
  desc 'Start step'
  task :start do
    logger.vizion_started '1.0.0'
  end

  desc 'Install command line developer tools, Oh My Zshell, Brew'
  task :base do
    logger.step 'Base', 'Installing oh-my-zsh and brew'

    _, stderr, status = installer.sh 'ls -a ~ | grep .oh-my-zsh'

    if status.success?
      logger.oh_my_zsh_skipped
    else
      _, stderr, status = installer.sh oh_my_zsh_install_command
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
      installer.shell homebrew_install_command, true
      installer.shell "echo 'eval \"$(/opt/homebrew/bin/brew shellenv)\"' >> ~/.zprofile", true
      installer.shell 'eval "$(/opt/homebrew/bin/brew shellenv)"', true
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

    stdout, _, status = installer.sh 'yarn global upgrade'

    if status.success?
      logger.yarn_package_installed 'packages' # hack
    else
      logger.yarn_package_not_installed 'packages' # hack
    end
  end

  desc 'Install Cargo global packages'
  task :cargo_packages do
    cargo_packages.each do |package|
      installer.sh "cargo install #{package} --quiet"
    end

    logger.write "Installed Cargo packages"
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

  desc 'Install nvim plugs'
  task :nvim_plugs do
    logger.step 'nvim plugs', 'Installing nvim plugs'

    installer.sh 'nvim --headless +PlugInstall +qall'
    logger.nvim_plugs_installed
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
    installer.shell './scripts/setup_grip.sh', false
    logger.write "Grip settings configured"
  end

  desc 'Gitconfig setup'
  task :gitconfig_setup do
    installer.shell './scripts/setup_gitconfig.sh local', true
    logger.write "Gitconfig configured"
  end

  desc 'Setup github tokens and rhubarb'
  task :github_tokens_and_rhubarb do
    installer.shell './scripts/setup_tokens.sh', false
    installer.shell './scripts/setup_rhubarb.sh', false
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
    :cargo_packages,
    :dotfiles,
    :directories,
    :oh_my_zsh_themes,
    :tmux_plugin_manager,
    :tmux_plugins,
    :nvim_plugs,
    :iterm2_profile,
    :visuals,
    :grip_settings,
    :gitconfig_setup,
    :github_tokens_and_rhubarb,
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
