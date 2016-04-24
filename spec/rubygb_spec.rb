require_relative "../lib/rubygb"
require "minitest/autorun"
require 'fileutils'

describe Rubygb do
  it "makes a gb file from a valid .s file" do
    tmp = Dir.mktmpdir
    Dir.chdir(tmp) do

      asm_file = File.join(File.dirname(__FILE__),"basic.s")
      FileUtils.copy(File.expand_path(asm_file), ".")

      Rubygb.build "basic.s"

      assert File.exists?("basic.gb"), "gb file should have been created"
    end
  end

  it "converts simple images correctly" do
    image_path = File.join(File.dirname(__FILE__),"test_image.png")
    result = Rubygb::Image.convert image_path


    assert_equal  8, result.pixel_height
    assert_equal  8, result.pixel_width
    assert_equal  1, result.tile_width
    assert_equal  1, result.tile_height
    assert_equal  16, result.tile_data_size



    file =  Rubygb::ImageTemplates.image result
    assert file.include?("DB $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0"), "result should contain correct tile data"
  end

  it "converts multicolor images correctly" do
    image_path = File.join(File.dirname(__FILE__),"test_8x8_4colors.png")
    result = Rubygb::Image.convert image_path


    assert_equal  8, result.pixel_height
    assert_equal  8, result.pixel_width
    assert_equal  1, result.tile_width
    assert_equal  1, result.tile_height
    assert_equal  16, result.tile_data_size

    file =  Rubygb::ImageTemplates.image result
    assert file.include?("$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$0F,$F0,$0F,$F0,$0F,$F0,$0F"), "result should contain correct tile data"
  end

  it "converts multitile images correctly" do
    image_path = File.join(File.dirname(__FILE__),"test_16x8_4colors.png")
    result = Rubygb::Image.convert image_path

    assert_equal  8, result.pixel_height
    assert_equal  16, result.pixel_width
    assert_equal  2, result.tile_width
    assert_equal  1, result.tile_height
    assert_equal  16, result.tile_data_size

    image_path = File.join(File.dirname(__FILE__),"test_16x16_4colors.png")
    result = Rubygb::Image.convert image_path

    assert_equal  16, result.pixel_height
    assert_equal  16, result.pixel_width
    assert_equal  2, result.tile_width
    assert_equal  2, result.tile_height
    assert_equal  16, result.tile_data_size


    image_path = File.join(File.dirname(__FILE__),"test_48x48.png")
    result = Rubygb::Image.convert image_path

    assert_equal  48, result.pixel_height 
    assert_equal  48, result.pixel_width
    assert_equal  6, result.tile_width
    assert_equal  6, result.tile_height

    assert_equal  5, result.tilepalette.count

  end




  it "converts a crazy failing image correctly" do
    image_path = File.join(File.dirname(__FILE__),"test_posterised.png")
    result = Rubygb::Image.convert image_path

    assert_equal result.pixel_height, 144
    assert_equal  160, result.pixel_width 
    assert_equal  20, result.tile_width 
    assert_equal  18, result.tile_height 

    assert_equal  360, result.tilemap_data_size 
    assert result.tile_data_size == 3488, "should create 3488 bytes of tile data"
  end
end

