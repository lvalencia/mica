import Commander
import Foundation

struct CLIArgs {
  let program: Group?
  let chalk: ChalkConstructor?
  let listDevices: CLICommandConstructorWithFullArgs?
  let startSimualtor: CLICommandConstructorWithFullArgs?
  let installXCodeTools: CLICommandConstructorWithFullArgs?
}

class CLI {
  private let program: Group
  private let chalk: ChalkConstructor
  private let listDevices: CLICommandConstructorWithFullArgs
  private let startSimualtor: CLICommandConstructorWithFullArgs
  private let installXCodeTools: CLICommandConstructorWithFullArgs

  convenience init() {
    self.init(
      args: CLIArgs(
        program: nil,
        chalk: nil,
        listDevices: nil,
        startSimualtor: nil,
        installXCodeTools: nil
      )
    )
  }

  init(args: CLIArgs) {
    program = args.program ?? Group()
    chalk = args.chalk ?? toChalk

    listDevices = args.listDevices ?? createListDevicesCommand
    startSimualtor = args.startSimualtor ?? createStartSimulatorCommand
    installXCodeTools = args.installXCodeTools ?? createInstallXCodeToolsCommand

    buildCLI()
  }

  public func run() {
    program.run()
  }

  private func buildCLI() {
    let args = CLICommandArgs(
      chalk: chalk,
      simulatorController: nil,
      xcodeController: nil
    )

    addListDevices(args: args)
    addStartSimulator(args: args)
    addInstallXCodeTools(args: args)
  }

  private func addListDevices(args: CLICommandArgs) {
    let listDevicesName = "devices-list"
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
  }

  private func addStartSimulator(args: CLICommandArgs) {
    let startSimulatorName = "simulator-start"
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

  private func addInstallXCodeTools(args: CLICommandArgs) {
    let installXCodeToolsName = "xcode-install-tools"
    let installXCodeToolsDescription = String(
      chalk("Install the XCode Command Line Tools")
        .underlined()
    )
    let installXCodeToolsResult = installXCodeTools(
      installXCodeToolsName,
      installXCodeToolsDescription,
      args
    ).addTo(program: program)

    printAddResultFor(
      name: installXCodeToolsName, 
      result: installXCodeToolsResult
    )
  }

  private func printAddResultFor(name: String, result: AddToProgramResult) {
    if result.status == AddToProgramStatus.failure {
      switch result.error! {
      case AddToProgramErrorReason.duplicate:
        // @TODO - replace calls to print with logger that I can customize; e.g. this shouldn't log in built and installed version 
        print("Failed to add \(name) to commands, program already has command")
      }
    }
  }
}
