protocol XCodeController {
  func installXCodeTools() -> String
}

class XCodeSelect: SystemCaller, XCodeController {
  func installXCodeTools() -> String {
    return systemCall("xcode-select", ["--install"])
  }
}
