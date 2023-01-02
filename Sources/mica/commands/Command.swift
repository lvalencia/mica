import Commander

enum AddToProgramStatus {
  case success
  case failure
}

enum AddToProgramErrorReason {
  case duplicate
}

struct AddToProgramResult {
  let status: AddToProgramStatus
  let error: AddToProgramErrorReason?
}

protocol Command {
  func addTo(program: Group) -> AddToProgramResult
}

struct CLICommandArgs {
  let chalk: ChalkConstructor?
  let simulatorControl: SimulatorControl?
}

typealias CLICommandConstructorWithFullArgs = (String, String, CLICommandArgs?) -> Command

class CLICommand: Command {
  internal let name: String
  internal let description: String
  internal let chalk: ChalkConstructor
  internal let simulatorControl: SimulatorControl

  convenience init(name: String, description: String) {
    self.init(
      name: name,
      description: description,
      args: nil
    )
  }

  init(name: String, description: String, args: CLICommandArgs?) {
    self.name = name
    self.description = description
    chalk = args?.chalk ?? toChalk
    simulatorControl = args?.simulatorControl ?? SimCtl()
  }

  func addTo(program _: Commander.Group) -> AddToProgramResult {
    fatalError("Not Implemented")
  }
}