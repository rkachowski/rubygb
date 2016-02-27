module Rubygb
  def self.build filename, options={}
    unless File.exists? filename
      raise "Fatal: can't find #{filename}"
    end

    base = File.basename(filename, ".*")
    exe_path = File.expand_path(File.join(File.dirname(__FILE__),"..","rgbds"))

    raise "Assembly failed!" unless system("#{exe_path}/rgbasm -v -o#{base}.obj #{filename}")
    raise "Link failed!" unless system("#{exe_path}/rgblink -m#{base}.map -n#{base}.sym -o#{base}.gb #{base}.obj")

    unless options[:no_fix]
      raise "Header fix failed!" unless system("#{exe_path}/rgbfix -p0 -v #{base}.gb")
    end
  end
end

