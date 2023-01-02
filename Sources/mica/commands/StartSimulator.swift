import Commander
import Foundation

func createStartSimulatorCommand(name: String, description: String, args: CLICommandArgs?) -> Command {
  return StartSimulator(
    name: name, 
    description: name,
    args: args
    )
}

class StartSimulator: CLICommand {
  override func addTo(program: Group) -> AddToProgramResult {
    program.addCommand(
      name,
      description,
      command { (input: [String]) in
        self.startSimualtor(input.joined(separator: " "))
      }
    )
    return AddToProgramResult(
      status: AddToProgramStatus.success,
      error: nil
    )
  }

  private func startSimualtor(_ input: String) {
    // @TODO - Validate Input
    let startSimulatorMessage = chalk("Attempting to start \(input) Simulator...")
    print(startSimulatorMessage)

    let regex = try? NSRegularExpression(pattern: "\\n.*\\b\(input)\\b.*Shutdown.*\\n")
    if regex == nil {
      print(
        chalk("Error: Could not start simulator for \"\(input)\"")
          .backgroundWhite()
          .red()
      )
      return
    }

    let devices = simulatorControl.listDevices()
    let results: [NSTextCheckingResult] = regex!.matches(
      in: devices,
      range: NSRange(location: 0, length: devices.count)
    )

    if results.count < 1 {
      print(
        chalk("Error: Could not find device matching \(input)")
          .backgroundWhite()
          .red()
      )
      return
    }

    let device = NSString(string: devices).substring(with: results[0].range)
    if results.count > 1 {
      print(
        chalk("Warn: Input \"\(input)\" could refer to multiple devices, starting simulator for: \(device)")
          .backgroundWhite()
          .red()
      )
    }

    let udidRegex = try? NSRegularExpression(pattern: "[A-Z0-9]*-[A-Z0-9]*-[A-Z0-9]*-[A-Z0-9]*-[A-Z0-9]*")
    if udidRegex == nil {
      print(
        chalk("Error: Could not start simulator")
          .backgroundWhite()
          .red()
      )
      return
    }

    let udidResults: [NSTextCheckingResult] = udidRegex!.matches(
      in: device,
      range: NSRange(location: 0, length: device.count)
    )
    let udid = NSString(string: device).substring(with: udidResults[0].range)

    print(simulatorControl.startSimualtor(udid: udid))
  }
}
