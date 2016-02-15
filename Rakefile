require "bundler/gem_tasks"

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

task :buildgem do
	puts "Building"
	if  "1.0.0" =~ /^(\*|\d+(\.\d+){0,2}(\.\*)?)$/
		Rake::Task["build"].invoke
	end	
end

task :pushgem do
	puts "Building"
	if  "1.0.0" =~ /^(\*|\d+(\.\d+){0,2}(\.\*)?)$/
		Rake::Task["release"].invoke
		
	end	
end

task :test => :spec