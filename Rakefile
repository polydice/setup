namespace :brew do
  desc "Install Homebrew formula if it's missing"
  task :install, [:formula] do |t, args|
    if args[:formula].nil?
      puts "Usage: rake brew:install[<formula>]"
      next
    end

    if Homebrew.installed? args[:formula]
      puts "Found #{args[:formula]}"
    else
      puts "Installing #{args[:formula]}..."
      Homebrew.install args[:formula]
    end
  end

  namespace :cask do
    desc "Install app via Homebrew Cask if it's missing"
    task :install, [:app] do |t, args|
      if args[:app].nil?
        puts "Usage: rake brew:cask:install[<app>]"
        next
      end

      if HomebrewCask.installed? args[:app]
        puts "Found #{args[:app]}.app"
      else
        HomebrewCask.install args[:app]
      end
    end
  end
end


namespace :gem do
  desc "Install gem if it's missing"
  task :install, [:gem] do |t, args|
    if args[:gem].nil?
      puts "Usage: rake gem:install[<gem>]"
      next
    end

    if RubyGem.installed? args[:gem]
      puts "Found #{args[:gem]}"
    else
      puts "Installing #{args[:gem]}..."
      RubyGem.install args[:gem]
    end
  end
end


private


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
  @@gems = %x(gem list).split "\n"

  def self.installed? (a_gem)
    @@gems.any? { |item| a_gem == item.split(" ").first }
  end

  def self.install (a_gem)
    system "gem install #{a_gem} --no-ri --no-rdoc" unless a_gem.nil?
  end
end
