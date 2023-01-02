import Commander
import Foundation

class MicaCLI {
  private let program: Group
  private let chalk: ChalkConstructor
  private let simulatorControl: SimulatorControl

  init() {
    program = Group()
    chalk = { (data: String) -> Chalk in
      Chalk(data)
    }
    simulatorControl = SimCtl()

    buildCLI()
  }

  init(program: Group?, chalk: ChalkConstructor?, simulatorControl: SimulatorControl?) {
    self.program = program ?? Group()

    self.chalk = chalk ?? { (data: String) -> Chalk in
      Chalk(data)
    }

    self.simulatorControl = simulatorControl ?? SimCtl()

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

    ListDevices(
      name: "list-devices",
      description: String(
        chalk("list all the devices and runtimes available on your mac")
          .underlined()
      ),
      args: args
    ).addTo(program: program)

    StartSimulator(
      name: "start-simulator",
      description: String(
        chalk("start specified simulator device")
          .underlined()
      ),
      args: args
    ).addTo(program: program)
  }
}
