require 'open3'

require_relative 'logger.rb'

class Installer
  def initialize
    @brew_not_installed = []
    @brew_cask_not_installed = []
    @shell_not_installed = []
    @logger = Logger.new
  end

  def get_versions output
    semver_pattern = /(\d+\.\d+\.\d+)/ # 5.3.1
    custom_pattern = /(\d+\.\d+\_\d+)/ # 5.3_1

    versions = output.scan semver_pattern 
    versions = output.scan custom_pattern if versions.empty?

    return versions.flatten
  end


  def brew_install formula
    stdout, stderr, status = Open3.capture3 "brew install #{formula}"
    
    if status.success?
      if stderr.include? "up-to-date"
        current_version = get_versions(stderr).shift
        @logger.brew_formula_up_to_date formula, current_version
      else
        version = get_versions(stdout).shift
        @logger.brew_formula_installed formula, version 
      end
    else
      if stderr.include? "To upgrade"
        versions = get_versions stderr 
        current_version = versions.shift
        new_version = versions.shift

        @logger.brew_formula_update_available formula, current_version, new_version 
      else
        if stderr.include? "No available formula"
          @logger.brew_formula_does_not_exist formula 
        else
          @logger.brew_formula_not_installed formula 
        end
        @brew_not_installed.push formula 
      end
    end
  end

  def brew_cask_install formula 
    stdout, stderr, status = Open3.capture3 "brew cask install #{formula}"

    if status.success?
      if stderr.include? "already installed"
        @logger.brew_cask_formula_already_installed formula
      else 
        version = get_versions(stdout).shift
        @logger.brew_cask_formula_installed formula, version
      end
    else
      if stderr.include? "No Cask with this name exists"
        @logger.brew_cask_formula_not_found formula
      elsif stderr.include? "there is already an App"
        @logger.brew_cask_formula_app_existing_already formula
      else
        @logger.brew_cask_formula_failed formula
      end
      @brew_cask_not_installed.push(formula)
    end
  end

  def sh command
    return Open3.capture3 command
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
