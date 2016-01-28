require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'test/**/*_test.rb'
  t.libs.push 'test'
  t.libs.push 'domain'
  t.libs.push 'application'
end

task default: :test
