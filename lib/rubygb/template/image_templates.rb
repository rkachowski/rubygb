module Rubygb
  class ImageTemplates
    def self.image image
%(
;
; Image file
; Name : #{image.name}


; Attributes
#{image.name}_tilemap_size EQU $#{hex(image.tilemap_data_size)}
#{image.name}_tilemap_width EQU $#{hex(image.tile_width)}
#{image.name}_tilemap_height EQU $#{hex(image.tile_height)}

#{image.name}_tiledata_size EQU $#{hex(image.tile_data_size)}
#{image.name}_tiledata_count EQU $#{hex(image.tilepalette.values.count)}


#{image.name}_tilemap_data:
#{format_to_asm(image.tilemap.map{|t| hex(t)})}

#{image.name}_tiledata:
#{format_to_asm(image.tilepalette.values.flatten, true)}

)
    end
    def self.format_to_asm data, pad=false
      result = []
      data.each_slice(16) do |slice|
        #pad data if this row is less than 16 bytes
        if pad
          (16 - slice.count).times do |pad|
            slice << "00"
          end
        end

        result << "DB #{slice.map{|s| "$" + s}.join(",")}"
      end
      result.join "\n"
    end

    def self.hex num
      sprintf("%02x", num).upcase
    end
  end


end
