module Rubygb
  def self.build filename, options={}
    unless File.exists? filename
      raise "Fatal: can't find #{filename}"
    end

    if options[:output]
      Dir.mkdir(options[:output]) unless Dir.exists? options[:output]
    end

    base = File.basename(filename, ".*")
    exe_path = File.expand_path(File.join(File.dirname(__FILE__),"..","rgbds"))

    obj_file, map_file, sym_file, rom_file = %w(.obj .map .sym .gb).map do |ext|
      options[:output] ? File.join(options[:output], "#{base}#{ext}") : "#{base}#{ext}"
    end

    raise "Assembly failed!" unless system("#{exe_path}/rgbasm -v -o#{obj_file} #{filename}")

    raise "Link failed!" unless system("#{exe_path}/rgblink -m#{map_file} -n#{sym_file} -o#{rom_file} #{obj_file}")

    unless options[:no_fix]
      raise "Header fix failed!" unless system("#{exe_path}/rgbfix -p0 -v #{rom_file}")
    end
  end
end

