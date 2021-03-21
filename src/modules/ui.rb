module UI
  COLORS = {
    black: "\u001b[30m",
    red: "\u001b[31m",
    green: "\u001b[32m",
    yellow: "\u001b[33m",
    blue: "\u001b[34m",
    magenta: "\u001b[35m",
    cyan: "\u001b[36m",
    white: "\u001b[37m",
    reset: "\u001b[0m"
  }

  module_function

  def print(message, color = :reset, breakline: true)
    super COLORS[color]
    super message
    super COLORS[:reset]
    super "\n" if breakline
  end

  def ask(message, color = :yellow)
    print(message, color, breakline: false)
    gets.strip
  end
end
