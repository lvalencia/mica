import Commander
import Foundation

enum InputValidity {
  case valid
  case invalid
}

struct ValidateInputResult {
  let validity: InputValidity
  let error: String
  let inputAsRegex: NSRegularExpression?
}

class StartSimulator: CLICommand {
  override internal func executeCommand(args: [String]) {
    let input = args.joined(separator: " ")

    let validityResult = validate(input: input)
    if validityResult.validity == InputValidity.invalid {
      print(validityResult.error)
      return
    }

    let startSimulatorMessage = chalk("Attempting to start \(input) Simulator...")
    print(startSimulatorMessage)

    let regex = validityResult.inputAsRegex!
    let devices = simulatorController.listDevices()

    // @TODO - Dependency Inject Function
    let matchRegexResult = matchRegex(
      string: devices,
      regex: regex
    )

    if matchRegexResult.status == MatchRegexStatus.nomatch {
      print(
        asError("Error: Could not find device matching \(input)")
      )
    }

    let results = matchRegexResult.results
    let device = NSString(string: devices).substring(with: results[0].range)
    if matchRegexResult.count > 1 {
      print(
        asError("Warn: Input \"\(input)\" could refer to multiple devices, starting simulator for: \(device)")
      )
    }

    // the try regex pattern coudl be extrapolated into a helper that returns success and data
    // there's a lot of strucs using this success / failure and then associated data pattern, we can make that generic
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

    print(simulatorController.startSimualtor(udid: udid))
  }

  private func validate(input: String) -> ValidateInputResult {
    var validity = InputValidity.valid
    var error = ""

    if input.isEmpty {
      validity = InputValidity.invalid
      error = "No Device Specified ; Please specify device or universal device id."
    }

    let inputAsRegex: NSRegularExpression? = try? NSRegularExpression(pattern: "\\n.*\\b\(input)\\b.*Shutdown.*\\n")
    if inputAsRegex == nil {
      validity = InputValidity.invalid
      error = "Error: Could not start simulator for \"\(input)\""
    }

    return ValidateInputResult(
      validity: validity,
      error: asError(error),
      inputAsRegex: inputAsRegex
    )
  }

  private func asError(_ str: String) -> String {
    return String(
      chalk(str)
        .backgroundWhite()
        .red()
    )
  }
}
