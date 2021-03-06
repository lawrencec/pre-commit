class Utils

  def self.staged_files(*dirs)
    dirs = reject_missing(dirs)

    @staged_files ||= {}
    @staged_files[dirs.join(' ')] ||= `git diff --cached --name-only --diff-filter=ACM #{dirs.join(' ')} | xargs`.chomp
  end

  def self.new_files(*dirs)
    @new_files ||= {}
    @new_files[dirs.join(' ')] ||= `git status --short #{dirs.join(' ')} | grep ^A | xargs`.chomp.split("A ").join(" ")
  end

  def self.reject_missing(dirs)
    dirs.reject { |dir| !File.exist?(dir) }
  end

end
