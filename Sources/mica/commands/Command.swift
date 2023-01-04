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
  let simulatorController: SimulatorController?
  let xcodeController:  XCodeController?
}

typealias CLICommandConstructorWithFullArgs = (String, String, CLICommandArgs?) -> Command

class CLICommand: Command {
  internal let name: String
  internal let description: String
  internal let chalk: ChalkConstructor
  internal let simulatorController: SimulatorController
  internal let xcodeController: XCodeController

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
    simulatorController = args?.simulatorController ?? SimCtl()
    xcodeController = args?.xcodeController ?? XCodeSelect()
  }

  func addTo(program: Commander.Group) -> AddToProgramResult {
    program.addCommand(
      name,
      description,
      command { (input: [String]) in
        self.executeCommand(args: input)
      }
    )
    return AddToProgramResult(
      status: AddToProgramStatus.success,
      error: nil
    )
  }

  internal func executeCommand(args: [String]) {
      fatalError("Attempted to execute abstract method #executeCommand");
  }
}
