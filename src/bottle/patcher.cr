class Bottle::Patcher
  getter application : String
  property config : Config

  def initialize(@application : String)
    @config = Config.new
  end

  def dispatch(config : Config = self.config)
    {% begin %}
      case application
        {% for name in ["github", "vscode"] %}
      when "{{name.id}}"
        Config.{{name.id}} config
        file_exist? { perform { Render.completed } }
        {% end %}
      else
        Render.not_found application
      end
    {% end %}
  end

  def file_exist?(config : Config = self.config, &block)
    config.matchs.each_with_index do |match, index|
      Utils.ask_directory match.ask do |dir|
        match.fileName.each do |file_name|
          path = String.build { |io| io << dir << file_name }
          abort Render.not_found path unless File.file? path
        end

        config.matchs[index].dir = dir
      end
    end

    yield
  end

  def perform(config : Config = self.config)
    config.matchs.each do |match|
      match.fileName.each do |file_name|
        path = String.build { |io| io << match.dir << file_name }

        Utils.read path do |data|
          match.entry.each { |entry| data = data.gsub entry.from, entry.to }
          Utils.write(path, data) { Render.done path }
        end
      end
    end

    yield
  end
end
