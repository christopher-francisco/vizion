class Logger
  def format message
    return message
      .gsub('[clear]', "\e[0m") 
      .gsub('[bold]', "\e[1m") 
      .gsub('[black]', "\e[30m") 
      .gsub('[red]', "\e[31m") 
      .gsub('[green]', "\e[32m") 
      .gsub('[yellow]', "\e[33m") 
      .gsub('[blue]', "\e[34m") 
      .gsub('[magenta]', "\e[35m") 
      .gsub('[cyan]', "\e[36m") 
      .gsub('[light_gray]', "\e[37m") 
      .gsub('[dark_gray]', "\e[90m") 
      .gsub('[light_blue]', "\e[94m") 
      .gsub('[light_cyan]', "\e[96m") 
      .gsub('[white]', "\e[97m") 
      .gsub('[b:blue]', "\e[44m") 
      .gsub('[check]', "✓")
      .gsub('[cross]', "✘")
      .gsub('[dot]', "•")
  end

  def write message 
    puts self.format message 
  end

  def step step, description 
    self.blank_line
    self.write "[b:blue] [black]#{step} [clear] #{description}" 
  end

  #####################################################################
  # Format helpers
  #####################################################################
  def highlight word, color = ""
    return self.format "[bold]#{color}#{word}[clear]"
  end

  def highlight_y word 
    return self.highlight word, '[yellow]'
  end

  def highlight_r word 
    return self.highlight word, '[red]'
  end

  def highlight_b word 
    return self.highlight word, '[blue]'
  end

  def highlight_lb word 
    return self.highlight word, '[light_blue]'
  end

  def check
    return self.format "[green][check][clear]"
  end

  def cross
    return self.format "[red][cross][clear]"
  end

  def dot
    return self.format "[light_gray][dot][clear]"
  end

  def vizion_started version
    self.write "Vizion #{self.highlight_b version} started"
  end

  def vizion_ended
    self.write 'Done'
  end

  def blank_line
    self.write ''
  end

  #####################################################################
  # Base
  #####################################################################
  def xcode_tools_installed
    self.write " #{self.check} #{self.highlight_y "XCode command line tools"}" +
      " #{self.highlight "installed"}"
  end

  def xcode_tools_skipped
    self.write " #{self.dot} #{self.highlight_y "XCode command line tools"}" +
      " #{self.highlight "found"} and #{self.highlight "skipped"}"
  end

  def xcode_tools_not_installed
    self.write " #{self.cross} #{self.highlight_y "XCode command line tools"}" +
      " install #{self.highlight "failed"}"
  end

  def oh_my_zsh_installed
    self.write " #{self.check} #{self.highlight_y "oh-my-zsh"}" +
      " #{self.highlight "installed"}"
  end

  def oh_my_zsh_skipped
    self.write " #{self.dot} #{self.highlight_y "oh-my-zsh"}" +
      " #{self.highlight "found"} and #{self.highlight "skipped"}"
  end

  def oh_my_zsh_not_installed
    self.write " #{self.cross} #{self.highlight_y "oh-my-zsh"} install" +
      " #{self.highlight "failed"}"
  end

  def brew_installed
    self.write " #{self.check} #{self.highlight_y "brew"}" +
      " #{self.highlight "installed"}"
  end

  def brew_skipped
    self.write " #{self.dot} #{self.highlight_y "brew"}" +
      " #{self.highlight "found"} and #{self.highlight "skipped"}"
  end

  def brew_not_installed
    self.write " #{self.cross} #{self.highlight_y "brew"} install" +
      " #{self.highlight "failed"}"
  end

  #####################################################################
  # Brew
  #####################################################################
  def brew_tap_skipped tap
    self.write " #{self.dot} #{self.highlight_y tap}" +
      " #{self.highlight "found"} and #{self.highlight "skipped"}"
  end

  def brew_tap_success tap
    self.write " #{self.check} #{self.highlight_y tap}" +
      " #{self.highlight "tapped"}"
  end

  def brew_tap_failed tap
    self.write " #{self.cross} #{self.highlight_y tap} tap" +
      " #{self.highlight "failed"}"
  end

  #####################################################################
  # Brew
  #####################################################################
  def brew_formula_skipped formula
    self.write " #{self.dot} #{self.highlight_y formula}" +
      " #{self.highlight "found"} and #{self.highlight "skipped"}"
  end

  def brew_formula_installed formula, version
    self.write " #{self.check} #{self.highlight_y formula} at version" +
    " #{self.highlight_lb version} #{self.highlight "installed"}"
  end

  def brew_formula_up_to_date formula, version
    self.write " #{self.dot} #{self.highlight_y formula} at version" +
      " #{self.highlight_lb version} #{self.highlight "up-to-date"}"
  end

  def brew_formula_update_available formula, current_version, new_version 
    self.write " #{self.dot} #{self.highlight_y formula} at version" +
      " #{self.highlight_lb current_version} #{self.highlight "found"}." +
      " Version #{self.highlight_lb new_version} #{self.highlight "available"}"
  end

  def brew_formula_does_not_exist formula 
    self.write " #{self.cross} #{self.highlight_y formula}" +
      " #{self.highlight "not found"}"
  end

  def brew_formula_not_installed formula 
    self.write " #{self.cross} #{self.highlight_y formula} install"
      + " #{self.highlight "failed"}"
  end

  #####################################################################
  # Brew Cask
  #####################################################################
  def brew_cask_formula_skipped formula
    self.write " #{self.dot} #{self.highlight_y formula}" +
      " #{self.highlight "found"} and #{self.highlight "skipped"}"
  end

  def brew_cask_formula_already_installed formula
    self.write " #{self.dot} #{self.highlight_y formula} already" +
      " #{self.highlight "installed"}"
  end

  def brew_cask_formula_installed formula, version
    self.write " #{self.check} #{self.highlight_y formula} at version" +
    " #{self.highlight_lb version} #{self.highlight "installed"}"
  end

  def brew_cask_formula_not_found formula 
    self.write " #{self.cross} #{self.highlight_y formula}" +
      " #{self.highlight "not found. Perhaps a `brew tap` is needed?"}"
  end

  def brew_cask_formula_not_found formula 
    self.write " #{self.cross} #{self.highlight_y formula}" +
      " #{self.highlight "not found"}. Perhaps a `brew tap` is needed?"
  end

  def brew_cask_formula_app_existing_already formula 
    self.write " #{self.dot} #{self.highlight_y formula}" +
      " #{self.highlight "already exists"} at /Applications"
  end

  def brew_cask_formula_failed formula 
    self.write " #{self.cross} #{self.highlight_y formula} install"
      + " #{self.highlight "failed"}"
  end

  #####################################################################
  # Yarn Packages
  #####################################################################
  def yarn_package_installed package
    self.write " #{self.check} #{self.highlight_y package}" +
      " #{self.highlight "installed"}"
  end

  def yarn_package_skipped package
    self.write " #{self.dot} #{self.highlight_y package}" +
      " #{self.highlight "found"} and #{self.highlight "skipped"}"
  end

  def yarn_package_not_installed package
    self.write " #{self.cross} #{self.highlight_y package} install" +
      " #{self.highlight "failed"}"
  end

  #####################################################################
  # TPM
  #####################################################################
  def tmux_plugin_manager_installed
    self.write " #{self.check} #{self.highlight_y "Tmux Plugin Manager"}" +
      " #{self.highlight "installed"}"
  end

  def tmux_plugin_manager_skipped
    self.write " #{self.dot} #{self.highlight_y "Tmux Plugin Manager"}" +
      " #{self.highlight "found"} and #{self.highlight "skipped"}"
  end

  #####################################################################
  # Tmux plugins
  #####################################################################
  def tmux_plugins_installed
    self.write " #{self.check} #{self.highlight_y "Tmux plugins"}" +
      " #{self.highlight "installed"}"
  end

  #####################################################################
  # Vim plugs
  #####################################################################
  def vim_plugs_installed
    self.write " #{self.check} #{self.highlight_y "Vim plugs"}" +
      " #{self.highlight "installed"}"
  end

  #####################################################################
  # Dotfiles
  #####################################################################
  def dotfile_count count
    self.write "There are #{self.highlight_b count} dotfiles to be linked"
  end

  def dotfile_linked dotfile
    self.write " #{self.check} #{self.highlight_y dotfile}" +
      " #{self.highlight "linked"}"
  end

  def dotfile_not_linked dotfile
    self.write " #{self.dot} #{self.highlight_y dotfile}" +
      " #{self.highlight "not linked. A file, directory or symlink already exist"}"
  end

  #####################################################################
  # Directories
  #####################################################################
  def directory_count count
    self.write "There are #{self.highlight_b count} directories to be linked"
  end

  def directory_linked directory
    self.write " #{self.check} #{self.highlight_y directory}" +
      " #{self.highlight "linked"}"
  end

  def directory_not_linked directory
    self.write " #{self.dot} #{self.highlight_y directory}" +
      " #{self.highlight "not linked. A file, directory or symlink already exist"}"
  end

  #####################################################################
  # Oh My Zsh Themes
  #####################################################################
  def oh_my_zsh_theme_count count
    self.write "There are #{self.highlight_b count} oh_my_zsh_themes to be linked"
  end

  def oh_my_zsh_theme_linked theme
    self.write " #{self.check} #{self.highlight_y theme}" +
      " #{self.highlight "linked"}"
  end

  def oh_my_zsh_theme_not_linked theme
    self.write " #{self.dot} #{self.highlight_y theme}" +
      " #{self.highlight "not linked. A file, directory or symlink already exist"}"
  end

  #####################################################################
  # iTerm2
  #####################################################################
  def iterm2_configured
    self.write " #{self.check} #{self.highlight_y "iTerm2"}" +
      " #{self.highlight "configured"}"
  end

  #####################################################################
  # Visuals
  #####################################################################
  def true_colors_and_italics_configured
    self.write " #{self.check} #{self.highlight_y "true color and itallics"}" +
      " #{self.highlight "configured"}"
  end
end
