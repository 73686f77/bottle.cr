module Bottle::Utils
  def self.input(prompt : String = String.new) : String
    String.new LibReadline.readline prompt
  end

  def self.ask_directory(ask : String)
    loop do
      Render.enter ask

      i = input
      i += "/" unless '/' == i[-1_i32]
      input = i.gsub /\\ /, " "

      break yield input if File.directory? input
      Render.invalid_directory
    end
  end

  def self.read(oath : String, &block : String ->)
    begin
      yield File.read oath
    rescue ex
      raise ReadFailed.new ex.message
    end
  end

  def self.write(path, text : String, &block)
    begin
      File.write path, text, mode: "wb"

      yield
    rescue ex
      raise WriteFailed.new ex.message
    end
  end
end
