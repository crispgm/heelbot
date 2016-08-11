# coding: utf-8

task default: %w[test]

task :test do
  sh "bundle exec ruby test/test_bot_manager.rb"
  sh "bundle exec ruby test/test_bot.rb"
  sh "bundle exec ruby test/test_shell.rb"
  sh "bundle exec ruby test/test_command.rb"
  sh "bundle exec ruby test/test_mail.rb"
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
