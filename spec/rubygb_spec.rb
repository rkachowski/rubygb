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
end

