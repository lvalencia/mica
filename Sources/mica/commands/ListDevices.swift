import Commander

func createListDevicesCommand(name: String, description: String, args: CLICommandArgs?) -> Command {
  return ListDevices(
    name: name, 
    description: name,
    args: args
  )
}

class ListDevices: CLICommand {
  override internal func executeCommand(args: [String]) {
    let listingDevicesMessage = chalk("Listing Devices on your machine...")
      .backgroundWhite()
      .cyan()

    print(listingDevicesMessage)
    print(simulatorController.listDevices())
  }
}
