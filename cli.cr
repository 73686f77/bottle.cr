require "./src/bottle.cr"

case ARGV[0_i32]?
when "version", "--version", "-v"
  STDOUT.puts <<-EOF
    Version:
      Bottle.cr :: App Beautification
      _Version_ :: #{Bottle::VERSION} (2020.06.22)
    EOF
when "help", "--help", "-h"
  STDOUT.puts <<-EOF
    Usage: bottle [command] [--] [arguments]
    Command:
      version, --version, -v  Display Version Information of Bottle.cr
      help, --help, -h        Show this Bottle: App Beautification Help
      vscode, github, ...     Beautify the Application Client Interface
    EOF
when String
  name = ARGV[0_i32]? || String.new

  patcher = Bottle::Patcher.new name
  patcher.dispatch
end
