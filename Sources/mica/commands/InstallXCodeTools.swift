func createInstallXCodeToolsCommand(name: String, description: String, args: CLICommandArgs?) -> Command {
  return InstallXCodeTools(
    name: name, 
    description: name,
    args: args
  )
}

class InstallXCodeTools: CLICommand {
  override internal func executeCommand(args: [String]) {
    let installingXCodeToolsMessage = chalk("Listing Devices on your machine...")
      .backgroundWhite()
      .cyan()

    print(installingXCodeToolsMessage)
    print(xcodeController.installXCodeTools())
  }
}