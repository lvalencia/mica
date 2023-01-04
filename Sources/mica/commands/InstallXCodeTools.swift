class InstallXCodeTools: CLICommand {
  override internal func executeCommand(args: [String]) {
    let installingXCodeToolsMessage = chalk("Listing Devices on your machine...")
      .backgroundWhite()
      .cyan()

    print(installingXCodeToolsMessage)
    print(xcodeController.installXCodeTools())
  }
}