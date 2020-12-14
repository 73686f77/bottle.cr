class Bottle::Config
  property matchs : Array(Match)

  def initialize
    @matchs = [] of Match
  end

  def self.github(config : Config)
    match = Match.new
    Match::Entry.github match
    match.fileName << "renderer.css"
    match.fileName << "index.html"
    match.ask = "Resources/app Directory"
    config.matchs << match
  end

  def self.vscode(config : Config)
    match = Match.new
    Match::Entry.vscode match
    match.fileName << "workbench.desktop.main.css"
    match.ask = "app/out/vs/workbench Directory"
    config.matchs << match

    match = Match.new
    Match::Entry.vscode match
    match.fileName << "main.js"
    match.ask = "webview/browser/pre Directory"
    config.matchs << match
  end
end

class Match
  property fileName : Array(String)
  property dir : String
  property ask : String
  property entry : Array(Entry)

  def initialize
    @fileName = [] of String
    @dir = String.new
    @ask = String.new
    @entry = [] of Entry
  end

  class Entry
    property from : Regex
    property to : String

    def initialize(@from : Regex = (Regex.new String.new), @to : String = String.new)
    end

    def self.github(match : Match)
      entry = Entry.new
      entry.from = /(<div id=\'desktop-app-container\')>/
      entry.to = "\\1 style=\"font-family: Monaco\">"
      match.entry << entry

      entry = Entry.new
      entry.from = /(font-family: )var(.*?);/
      entry.to = "\\1Monaco;"
      match.entry << entry

      entry = Entry.new
      entry.from = /(.CodeMirror-code {\n)/
      entry.to = "\\1  font-family: Monaco;\n"
      match.entry << entry
    end

    def self.vscode(match : Match)
      entry = Entry.new
      entry.from = /(.mac\{font-family:).*?\}/
      entry.to = "\\1Monaco;}"
      match.entry << entry

      entry = Entry.new
      entry.from = /.monaco-workbench .part>.content\{font-size:\d+px\}/
      entry.to = ".monaco-workbench .part>.content{font-size:11px}"
      match.entry << entry

      entry = Entry.new
      entry.from = /.label-name\{font-style:italic\}/
      entry.to = ".label-name{font-style:nomal}"
      match.entry << entry

      entry = Entry.new
      entry.from = /font-family:var\(--monaco-monospace-font\)/
      entry.to = "font-family:Monaco;"
      match.entry << entry

      entry = Entry.new
      entry.from = /\{font-family:-apple-system,.*?\}/
      entry.to = "{font-family:Monaco;}"
      match.entry << entry

      entry = Entry.new
      entry.from = /.mtk1{/
      entry.to = ".mtk1{font-family:Monaco;"
      match.entry << entry
    end
  end
end
