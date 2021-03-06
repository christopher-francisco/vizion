class Linker
  def link original, symlink
    if Dir.exist?(symlink) || File.exists?(symlink) || File.symlink?(symlink)
      return false
    else
      Rake::FileUtilsExt.ln_s original, symlink, verbose: false
      return true
    end
  end

  def unlink symlink
    if File.symlink? symlink
      Rake::FileUtilsExt.safe_unlink symlink, verbose: false
      return true
    else
      return false
    end
  end
end
