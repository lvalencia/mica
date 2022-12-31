import ShellOut

protocol SimulatorControl {
  func listDevices() -> String
  func startSimualtor(udid: String) -> String
}

typealias SafeSystemCall = (String, [String]) -> String

class SimCtl: SimulatorControl {
  private let systemCall: SafeSystemCall

  init() {
    systemCall = { (command: String, args: [String]) -> String in
      SimCtl.safeSystemCall(command: command, args: args)
    }
  }

  init(systemCall: SafeSystemCall?) {
    self.systemCall = systemCall ?? { (command: String, args: [String]) -> String in
      SimCtl.safeSystemCall(command: command, args: args)
    }
  }

  public func listDevices() -> String {
    return systemCall("xcrun simctl", ["list"])
  }

  public func startSimualtor(udid: String) -> String {
    return systemCall("open", [
      "-a ",
      "Simulator ",
      "--args ",
      "-CurrentDeviceUDID",
      udid
    ]);
  }

  private static func safeSystemCall(command: String, args: [String]) -> String {
    do {
      return try shellOut(to: command, arguments: args)
    } catch {
      return (error as! ShellOutError).output
    }
  }
}
