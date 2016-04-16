# # #
# Get gemspec info

gemspec_file = Dir['*.gemspec'].first 
gemspec = eval File.read(gemspec_file), binding, gemspec_file
info = "#{gemspec.name} | #{gemspec.version} | " \
       "#{gemspec.runtime_dependencies.size} dependencies | " \
       "#{gemspec.files.size} files"


# # #
# Gem build and install task

desc info
task :gem => :check_debug do
  puts info + "\n\n"
  print "  "; sh "gem build #{gemspec_file}"
  FileUtils.mkdir_p 'pkg'
  FileUtils.mv "#{gemspec.name}-#{gemspec.version}.gem", 'pkg'
  puts; sh %{gem install --no-document pkg/#{gemspec.name}-#{gemspec.version}.gem}
end

desc "Check for debug code"
task :check_debug do
  output = `grep -irl binding\.pry lib`
  abort "debug stuff still there " + output if $?.exitstatus == 0
  output = `grep -irl -e 'require.*pry' lib`
  abort "debug stuff still there " + output if $?.exitstatus == 0
end


# # #
# Start an IRB session with the gem loaded

desc "#{gemspec.name} | IRB"
task :irb do
  sh "irb -I ./lib -r #{gemspec.name.gsub '-','/'}"
end
