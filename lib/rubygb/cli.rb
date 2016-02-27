require 'thor'
require 'fileutils'
require 'pry-byebug'
module Rubygb
  class CLI < Thor
    desc 'build FILENAME', 'attempt to assemble, link + fix FILENAME and create a gb rom from it'
    option :no_fix, :type => :boolean
    def build filename
      Rubygb.build filename, options
    end

    desc 'init PROJECT_NAME', 'create a new gameboy project at the location'
    def init project_name
      puts "Creating new project at #{File.expand_path project_name}"
      raise "Project already exists at #{File.expand_path project_name}!"if Dir.exists? project_name

      Dir.mkdir project_name
      galp_dest = File.join(project_name,"lib")
      Dir.mkdir galp_dest
      galp_lib = File.expand_path(File.join(File.dirname(__FILE__),"..","galp"))

      Dir.glob(File.join(galp_lib,"*")) do |file|
        puts "copying #{File.basename(file)}..."
        FileUtils.copy file, galp_dest
      end

      template = Template.basic(project_name)

      File.open(File.join(project_name,"#{project_name}.s"),"w") {|f| f << template}
    end
  end
end
