namespace :brew do
  desc "Install Homebrew formula if it's missing"
  task :install, [:formula] do |t, args|
    install_package args[:formula], Homebrew, "Usage: rake brew:install[<formula>]"
  end

  namespace :cask do
    desc "Install app via Homebrew Cask if it's missing"
    task :install, [:app] do |t, args|
      install_package args[:app], HomebrewCask, "Usage: rake brew:cask:install[<app>]"
    end
  end
end


namespace :gem do
  desc "Install gem if it's missing"
  task :install, [:gem] do |t, args|
    install_package args[:gem], RubyGem, "Usage: rake gem:install[<gem>]"
  end
end


private


def install_package (package, manager, usage = "Usage: rake -T")
  if package.nil?
    puts usage
  elsif manager.installed? package
    puts "Found #{package}"
  else
    puts "Installing #{package}..."
    manager.install package
  end
end


class Homebrew
  @@formulae = %x(brew list).split "\n"
  @@outdated = %x(brew outdated).split "\n"

  def self.installed? (formula)
    @@formulae.include? formula
  end

  def self.hasOutdated? (formula)
    if formula.nil?
      false
    else
      @@outdated.include? formula
    end
  end

  def self.install (formula)
    system "brew install #{formula}" unless formula.nil?
  end

  def self.upgrade (formula)
    system "brew upgrade #{formula}" unless formula.nil?
  end
end


class HomebrewCask
  def self.installed? (app)
    File.exists? "/Applications/#{app}.app" or File.exists? File.expand_path "~/Applications/#{app}.app"
  end

  def self.install (app)
    system "brew cask install #{app}" unless app.nil?
  end
end


class RubyGem
  def self.installed? (a_gem)
    %x(gem list #{a_gem}).split("\n").any? { |item| a_gem == item.split(" ").first }
  end

  def self.install (a_gem)
    system "gem install #{a_gem} --no-ri --no-rdoc" unless a_gem.nil?
  end
end
