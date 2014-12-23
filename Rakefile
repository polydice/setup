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
