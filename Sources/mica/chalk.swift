import Chalk

typealias ChalkString = String

protocol ChalkObject: CustomStringConvertible {
  func bold() -> ChalkObject
  func dim() -> ChalkObject
  func italic() -> ChalkObject
  func underlined() -> ChalkObject
  func inverse() -> ChalkObject
  func strikethrough() -> ChalkObject
  func red() -> ChalkObject
  func green() -> ChalkObject
  func yellow() -> ChalkObject
  func blue() -> ChalkObject
  func magenta() -> ChalkObject
  func cyan() -> ChalkObject
  func white() -> ChalkObject
  func backgroundBlack() -> ChalkObject
  func backgroundRed() -> ChalkObject
  func backgroundGreen() -> ChalkObject
  func backgroundYellow() -> ChalkObject
  func backgroundBlue() -> ChalkObject
  func backgroundMagenta() -> ChalkObject
  func backgroundCyan() -> ChalkObject
  func backgroundWhite() -> ChalkObject
  func apply(color: Color) -> ChalkObject
  func apply(background: Color) -> ChalkObject
  func apply(style: Style) -> ChalkObject
  func apply(color: Color, background: Color) -> ChalkObject
  func apply(background: Color, style: Style) -> ChalkObject
  func apply(color: Color, style: Style) -> ChalkObject
  func apply(color: Color, background: Color, style: Style) -> ChalkObject
}

enum Chalkable {
  case object(ChalkObject)
  case string(ChalkString)
}

public class Chalk: ChalkObject {
  private var data: String

  public var description: String { return data }

  init(_ data: String) {
    self.data = data
  }

  func bold() -> ChalkObject {
    return apply(style: .bold)
  }

  func dim() -> ChalkObject {
    return apply(style: .dim)
  }

  func italic() -> ChalkObject {
    return apply(style: .italic)
  }

  func underlined() -> ChalkObject {
    return apply(style: .underlined)
  }

  func inverse() -> ChalkObject {
    return apply(style: .inverse)
  }

  func strikethrough() -> ChalkObject {
    return apply(style: .strikethrough)
  }

  func red() -> ChalkObject {
    return apply(color: .red)
  }

  func green() -> ChalkObject {
    return apply(color: .green)
  }

  func yellow() -> ChalkObject {
    return apply(color: .yellow)
  }

  func blue() -> ChalkObject {
    return apply(color: .blue)
  }

  func magenta() -> ChalkObject {
    return apply(color: .magenta)
  }

  func cyan() -> ChalkObject {
    return apply(color: .cyan)
  }

  func white() -> ChalkObject {
    return apply(color: .white)
  }

  func backgroundBlack() -> ChalkObject {
    return apply(background: .black)
  }

  func backgroundRed() -> ChalkObject {
    return apply(background: .red)
  }

  func backgroundGreen() -> ChalkObject {
    return apply(background: .green)
  }

  func backgroundYellow() -> ChalkObject {
    return apply(background: .yellow)
  }

  func backgroundBlue() -> ChalkObject {
    return apply(background: .blue)
  }

  func backgroundMagenta() -> ChalkObject {
    return apply(background: .magenta)
  }

  func backgroundCyan() -> ChalkObject {
    return apply(background: .cyan)
  }

  func backgroundWhite() -> ChalkObject {
    return apply(background: .white)
  }

  func apply(color: Color) -> ChalkObject {
    data = "\(data, color: color)"
    return self
  }

  func apply(background: Color) -> ChalkObject {
    data = "\(data, background: background)"
    return self
  }

  func apply(style: Style) -> ChalkObject {
    data = "\(data, style: style)"
    return self
  }

  func apply(color: Color, background: Color) -> ChalkObject {
    data = "\(data, color: color, background: background)"
    return self
  }

  func apply(background: Color, style: Style) -> ChalkObject {
    data = "\(data, background: background, style: style)"
    return self
  }

  func apply(color: Color, style: Style) -> ChalkObject {
    data = "\(data, color: color, style: style)"
    return self
  }

  func apply(color: Color, background: Color, style: Style) -> ChalkObject {
    data = "\(data, color: color, background: background, style: style)"
    return self
  }
}

extension String {
  init(_ chalk: ChalkObject) {
    self = chalk.description
  }
}
