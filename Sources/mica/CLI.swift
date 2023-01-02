import Commander
import Foundation

struct MicaCLIArgs {
  let program: Group?
  let chalk: ChalkConstructor?
  let simulatorControl: SimulatorControl?
  let listDevices: CLICommandConstructorWithFullArgs?
  let startSimualtor: CLICommandConstructorWithFullArgs?
}

class MicaCLI {
  private let program: Group
  private let simulatorControl: SimulatorControl
  private let chalk: ChalkConstructor
  private let listDevices: CLICommandConstructorWithFullArgs
  private let startSimualtor: CLICommandConstructorWithFullArgs

  convenience init() {
    self.init(
      args: MicaCLIArgs(
        program: nil,
        chalk: nil,
        simulatorControl: nil,
        listDevices: nil,
        startSimualtor: nil
      )
    )
  }

  init(args: MicaCLIArgs) {
    program = args.program ?? Group()
    chalk = args.chalk ?? toChalk
    simulatorControl = args.simulatorControl ?? SimCtl()
    listDevices = args.listDevices ?? createListDevicesCommand
    startSimualtor = args.listDevices ?? createStartSimulatorCommand

    buildCLI()
  }

  public func run() {
    program.run()
  }

  private func buildCLI() {
    let args = CLICommandArgs(
      chalk: chalk,
      simulatorControl: simulatorControl
    )

    let listDevicesName = "list-devices"
    let listDevicesDescription = String(
      chalk("list all the devices and runtimes available on your mac")
        .underlined()
    )
    let addListDevicesResult = listDevices(
      listDevicesName,
      listDevicesDescription,
      args
    ).addTo(program: program)

    printAddResultFor(
      name: listDevicesName,
      result: addListDevicesResult
    )

    let startSimulatorName = "start-simulator"
    let startSimualtorDescription = String(
      chalk("start specified simulator device")
        .underlined()
    )
    let addStartSimulatorResult = startSimualtor(
      startSimulatorName,
      startSimualtorDescription,
      args
    ).addTo(program: program)

    printAddResultFor(
      name: startSimulatorName,
      result: addStartSimulatorResult
    )
  }

  func printAddResultFor(name: String, result: AddToProgramResult) {
    if result.status == AddToProgramStatus.failure {
      switch result.error! {
      case AddToProgramErrorReason.duplicate:
        // @TODO - replace calls to print with logger that I can customize; e.g. this shouldn't log in built and installed version 
        print("Failed to add \(name) to commands, program already has command")
      }
    }
  }
}
