import Commander

class ListDevices: CLICommand {
  override internal func executeCommand(args: [String]) {
    let listingDevicesMessage = chalk("Listing Devices on your machine...")
      .backgroundWhite()
      .cyan()

    print(listingDevicesMessage)
    print(simulatorController.listDevices())
  }
}
