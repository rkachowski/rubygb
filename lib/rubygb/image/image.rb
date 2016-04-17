
module Rubygb
  class Image
    attr_reader :name, :tilemap, :tilepalette, :pixel_height, :pixel_width
    TILE_WIDTH = 8.0
    TILE_HEIGHT = 8.0

    def initialize(name, tilemap, tilepalette, pixel_width, pixel_height)
      @tilepalette = tilepalette
      @tilemap = tilemap
      @name = name
      @pixel_width = pixel_width
      @pixel_height = pixel_height
    end

    def tile_width
      (@pixel_width / TILE_WIDTH).ceil
    end

    def tile_height
      (@pixel_height / TILE_HEIGHT).ceil
    end

    def self.convert png
      require 'RMagick'

      image = Magick::ImageList.new png
      pixels = image.export_pixels
      converted = []

      #reduce color information to an array of rgb value for each pixel
      (0...pixels.length).step(3) do |i|
        converted << [pixels[i], pixels[i+1], pixels[i+2]]
      end

      #find the unique colors
      color_palette = converted.uniq.sort.inject({}) do |hsh, val|
        hsh[val] = hsh.count
        hsh
      end

      #ghetto rgb to luma
      luma = ->(col){ (col[0]*2 + col[2] + col[1]*3) / 6.0}

      #todo: assert palette is 4 colors at most

      while color_palette.count < 4 do
        pad_color = [32767,32767,32764 + color_palette.count]
        color_palette[pad_color] = color_palette.count
      end

      #sort from darkest to lightest
      sorted_palette = color_palette.keys.sort {|a,b| luma.call(b) - luma.call(a) }

      #replace colors with index in palette
      converted.map! { |color| sorted_palette.index color }

      #calculate tiles
      tiles = []
      x_tiles = (image.columns / TILE_WIDTH).ceil
      y_tiles = (image.rows / TILE_HEIGHT).ceil

      y_tiles.times do |y|
        x_tiles.times do |x|
          tile = []
          (TILE_HEIGHT).floor.times do |row|
            start_index = (x * TILE_WIDTH) + (y * TILE_HEIGHT * image.columns) + (row * image.columns)
            tile << converted.slice(start_index, TILE_WIDTH)
          end
          tiles << tile
        end
      end

      tile_palette = tiles.uniq.inject({}) { |hsh, tile| hsh[tile] = hsh.count; hsh }
      tile_map = tiles.map { |t| tile_palette[t] }

      binary_tile_palette = {}
      tile_palette.each do |tile, index|
        binary_tile_palette[index] = tile_to_binary tile
      end

      Image.new File.basename(png, ".*"), tile_map, binary_tile_palette, image.columns, image.rows
    end

    def tile_data_size
      (@tilepalette.values.count * 8 * 2)
    end

    def tilemap_data_size
      tile_width * tile_height
    end

    def self.tile_to_binary tile
      output = []

      tile.each do |row|
        b1 = []
        b2 = []
        row.each do |color|
          case color
            when 0
              b1 << "0"
              b2 << "0"
            when 1
              b1 << "1"
              b2 << "0"
            when 2
              b1 << "0"
              b2 << "1"
            when 3
              b1 << "1"
              b2 << "1"
          end
        end
        output << b1
        output << b2
      end

      output.map do |row|
        sprintf("%02x",row.join.to_i(2)).upcase
      end
    end
  end
end
