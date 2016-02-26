require 'thor'

module Rubygb
  class CLI < Thor
    desc 'build FILENAME', 'attempt to assemble, link + fix FILENAME and create a gb rom from it'
    option :no_fix, :type => :boolean
    def build filename
      Rubygb.build filename, options
    end
  end
end
