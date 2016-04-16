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

  it "converts images correctly" do
    image_path = File.join(File.dirname(__FILE__),"test_image.png")
    result = Rubygb::Image.convert image_path


    assert result.pixel_height == 8
    assert result.pixel_width == 8
    assert result.tile_width == 1
    assert result.tile_height == 1
    assert result.tile_data_size == 16



    file =  Rubygb::ImageTemplates.image result
    assert file.include?("DB $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0"), "result should contain correct tile data"
  end
end

