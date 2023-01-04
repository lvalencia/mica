import ShellOut

typealias SafeSystemCall = (String, [String]) -> String

func safeSystemCall(command: String, args: [String]) -> String {
    do {
      return try shellOut(to: command, arguments: args)
    } catch {
      return (error as! ShellOutError).output
    }
}

class SystemCaller {
  internal let systemCall: SafeSystemCall

  convenience init() {
    self.init(
      call: { (command: String, args: [String]) -> String in
        safeSystemCall(command: command, args: args)
      } 
    )
  }

  init(call: @escaping SafeSystemCall) {
    self.systemCall = call
  }
}
