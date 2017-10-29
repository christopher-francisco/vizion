class Installer
  def initialize
    @brew_not_installed = []
    @brew_cask_not_installed = []
    @shell_not_installed = []
  end

  def brew(formula)
    unless system("brew install #{formula}")
      @brew_not_installed.push(formula)
    end
  end

  def brew_cask(formula)
    # brew-cask doesn't return 1 when a formula is already installed
    output = `brew cask install #{formula}`
    if output.include?('already installed')
      @brew_cask_not_installed.push(formula)
    end
  end

  def npm(package)
    Rake::FileUtilsExt.sh("npm install -g #{package}")
  end

  def shell(program, required = false)
    if required
      Rake::FileUtilsExt.sh(program)
    else
      unless system(program)
        @shell_not_installed.push(program)
      end
    end
  end
end

class Logger
  def write(message)
    puts message
  end

  def step(description)
    description = "-- #{description} "
    description = description.ljust(80, '-')
    puts
    puts "\e[32m#{description}\e[0m"
  end
end

class Linker
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
end

######################################################################################################
# Helper functions
######################################################################################################

logger = Logger.new
installer = Installer.new
# linker = Linker.new

######################################################################################################
# Installation
######################################################################################################

test_brew_formulas = ['wget']
test_brew_cask_formulas = ['atom']

namespace :test do
  desc 'Test brew'
  task :brew_install do
    test_brew_formulas.each do |formula|
      logger.step(formula)
      installer.brew(formula)
    end
  end

  desc 'Test brew-cask'
  task :brew_cask_install do
    test_brew_cask_formulas.each do |formula|
      logger.step(formula)
      installer.brew_cask(formula)
    end
  end

  task :all => [:brew_install, :brew_cask_install]
end


brew_formulas = [
  'ccat',
  'ctags',
  'editorconfig',
  'heroku',
  'neovim',
  'nvm',
  'ruby',
  'the_silver_searcher',
  'ripgrep',
  'tmux',
  'tmuxinator-completion',
  'tree',
  'wget',
  'yarn',
  'zsh',
  'zsh-autosuggestions',
  'zsh-completions',
  'zsh-syntax-highlighting',
]

brew_cask_formulas = [
  'atom',
  'docker',
  'font-fira-code',
  'google-chrome',
  'iterm2',
  'licecap',
  'macvim',
  'mysqlworkbench',
  'sequel-pro',
  'slack',
  'spectacle',
  'vagrant',
  'virtualbox',
  'visual-studio-code',
]

npm_packages = [
  'create-react-app',
  'vtop',
]

namespace :install do
  desc 'Install command line developer tools, Oh My Zshell, Brew'
  task :pre_requisites do
    output = `xcode-select -p` 
    unless output.include?('Developer') # TODO: What does the string contains when it's not installed??
      logger.write('Installing command lines developer tools. Might ask for password.')
      installer.shell('xcode-select --install', true)
    else
      logger.write('Developer command line tools already installed. Skipping...')
    end

    unless system('ls -a ~ | grep .oh-my-zsh')
      logger.write('Installing Oh My Zshell')
      installer.shell('sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"', true)
    else
      logger.write('Oh My Zshell already installed. Skipping...')
    end

    unless system('which brew')
      logger.write('Installing Oh My Zshell')
      installer.shell('/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"', true)
    else
      logger.write('Brew installed. Skipping...')
    end
  end

  desc 'Install brew formulas'
  task :brew_formulas do
    brew_formulas.each do |formula|
      logger.step(formula)
      installer.brew(formula)
    end
  end

  desc 'Install brew-cask formulas'
  task :brew_cask_formulas do
    brew_cask_formulas.each do |formula|
      logger.step(formula)
      installer.brew_cask(formula)
    end
  end

  desc 'Install node and global npm packages'
  task :node_and_npm do
    logger.write('Installing latest version of node')
    installer.shell('nvm install node')

    npm_packages.each do |package|
      installer.npm(package);
    end
  end

  desc 'Tmux Plugin Manager'
  task :tmux_plugin_manager do
    unless system('ls ~/.tmux/plugins/tpm')
      logger.write('Installing Tmux Plugin Manager')
      installer.shell('git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm')
    else
      logger.write('Tmux Plugin Manager already installed. Skipping...')
    end

    # TODO: run prefix+I
  end

  # TODO:  Vim 8 (from MacVim) should be installed and accessible from the SHELL
  desc 'Vundle'
  task :vundle do
    unless system('ls ~/.vim/bundle/Vundle.vim')
      logger.write('Installing Vundle')
      installer.shell('git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim')
    else
      logger.write('Vundle already installed. Skipping...')
    end

    installer.shell('vim +PluginInstall +qall')
  end

  desc 'Link dotfiles'
  task :dotfiles do
  end

  task :all => [
    :pre_requisites,
    :brew_formulas,
    :brew_cask_formulas,
    :node_and_npm,
    :dotfiles,
    :tmux_plugin_manager,
    :vundle
  ]
end

task :default => 'install:all'
task :test => 'test:all'
