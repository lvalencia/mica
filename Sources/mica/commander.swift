import Foundation
import Commander

typealias ChalkConstructor = (String) -> Chalk

class MicaCLI {
  private let program: Group
  private let chalk: ChalkConstructor
  private let simulatorControl: SimulatorControl

  init() {
    self.program = Group()
    self.chalk = { (data: String) -> Chalk in
      return Chalk(data)
    }
    self.simulatorControl = SimCtl()

    buildCLI()
  }

  init(program: Group?, chalk: ChalkConstructor?, simulatorControl: SimulatorControl?) {
    self.program = program ?? Group()
  
    self.chalk = chalk ?? { (data: String) -> Chalk in
      return Chalk(data)
    }

    self.simulatorControl = simulatorControl ?? SimCtl()

    buildCLI()
  }

  public func run() -> Void {
    program.run()
  }

  private func buildCLI() -> Void {
    addListDevices()
    addStartSimulator()
  }

  private func addListDevices() -> Void {
    let name = "list-devices"
    let description = self.chalk("list all the devices and runtimes available on your mac")
      .underlined()
      
    program.addCommand(name, String(description), command {
      self.listDevices()
    })
  }

  private func listDevices() -> Void {
    let listingDevicesMessage = self.chalk("Listing Devices on your machine...")
      .backgroundWhite()
      .cyan();

    print(listingDevicesMessage);
    print(self.simulatorControl.listDevices());
  }

  private func addStartSimulator() -> Void {
    let name = "start-simulator"
    let description = self.chalk("start specified simulator device")
      .underlined()

    program.addCommand(name, String(description), command { (input: [String]) in
      self.startSimulator(input.joined(separator: " "))
    });
  }

  private func startSimulator(_ input: String) -> Void {
    let startSimulatorMessage = self.chalk("Attempting to start \(input) Simulator...")
    print(startSimulatorMessage)

    let regex = try? NSRegularExpression(pattern: "\\n.*\\b\(input)\\b.*Shutdown.*\\n")
    if (regex == nil) {
      print(
        self.chalk("Error: Could not start simulator for \"\(input)\"")
          .backgroundWhite()
          .red()
      )
      return
    }

    let devices = self.simulatorControl.listDevices()
    let results: [NSTextCheckingResult] = regex!.matches(
      in: devices,
      range: NSRange(location: 0, length: devices.count)
    )

    if (results.count < 1) {
      print(
        self.chalk("Error: Could not find device matching \(input)")
          .backgroundWhite()
          .red()
      )
      return 
    }

    let device = NSString(string: devices).substring(with: results[0].range);
    if (results.count > 1) {
      print(
        self.chalk("Warn: Input \"\(input)\" could refer to multiple devices, starting simulator for: \(device)")
          .backgroundWhite()
          .red()
      )
    }

    let udidRegex = try? NSRegularExpression(pattern: "[A-Z0-9]*-[A-Z0-9]*-[A-Z0-9]*-[A-Z0-9]*-[A-Z0-9]*")
    if (udidRegex == nil) {
      print(
        self.chalk("Error: Could not start simulator")
          .backgroundWhite()
          .red()
      )
      return
    }

    let udidResults: [NSTextCheckingResult] = udidRegex!.matches(
      in: device,
      range: NSRange(location: 0, length: device.count)
    )
    let udid = NSString(string: device).substring(with: udidResults[0].range);

    print(self.simulatorControl.startSimualtor(udid: udid))
  }

}

