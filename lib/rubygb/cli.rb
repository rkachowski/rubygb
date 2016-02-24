require 'thor'

module Rubygb
  class CLI < Thor
    desc 'build FILENAME', 'attempt to assemble, link and fix FILENAME and create a gb rom from it'
    def build filename
      Rubygb.build filename
    end
  end
end
