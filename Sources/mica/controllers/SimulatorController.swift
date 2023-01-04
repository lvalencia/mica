protocol SimulatorController {
  func listDevices() -> String
  func startSimualtor(udid: String) -> String
}

class SimCtl: SystemCaller, SimulatorController {
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
}
