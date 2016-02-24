module Rubygb
  def self.build filename
    unless File.exists? filename
      raise "Fatal: can't find #{filename}"
    end

    base = File.basename(filename)

    `rgbasm -v -o#{base}.obj #{filename}`
    `rgblink -m#{base}.map -n#{base}.sym -o#{base}.gb #{base}.obj`
    `rgbfix -p0 -v #{base}.gb`
  end
end

