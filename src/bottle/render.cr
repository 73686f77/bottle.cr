module Bottle::Render
  def self.enter(text : String)
    STDOUT.print String.build { |io| io << "Enter " << text << ": " }
  end

  def self.error(text : String)
    STDOUT.puts String.build { |io| io << "Error ".colorize.red << text }
  end

  def self.invalid_directory
    error "The Directory is Invalid, Please try again."
  end

  def self.not_found(text : String)
    STDOUT.puts String.build { |io| io << "NotFound ".colorize.red << text }
  end

  def self.completed
    STDOUT.puts String.build { |io| io << "Completed".colorize.green }
  end

  def self.done(text : String)
    STDOUT.puts String.build { |io| io << "Done ".colorize.green << text }
  end
end
