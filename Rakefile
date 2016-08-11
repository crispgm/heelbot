# coding: utf-8
task default: %w[test]

task :init do
  sh "bundle install"
end

task :run do
  sh "bundle exec bin/heelbot"
end

task :test do
  sh "bundle exec ruby test/test_bot_manager.rb"
  sh "bundle exec ruby test/test_shell.rb"
end

task :count do
  files = `git ls-files -z`.split("\x0")
  shell_cmd = "wc -l "
  files.grep(%r{^(bin|lib|test|heelspec)/}).each do |f|
    shell_cmd << f << " \\\n"
  end
  begin
    sh shell_cmd[0..-3]
  rescue
  end
end
