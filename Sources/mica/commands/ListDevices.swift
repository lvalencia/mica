import Commander

func createListDevicesCommand(name: String, description: String, args: CLICommandArgs?) -> Command {
  return ListDevices(
    name: name, 
    description: name,
    args: args
    )
}

class ListDevices: CLICommand {
  override func addTo(program: Group) -> AddToProgramResult {
    program.addCommand(
      name,
      description,
      command {
        self.listDevices()
      }
    )
    return AddToProgramResult(
      status: AddToProgramStatus.success,
      error: nil
    )
  }

  private func listDevices() {
    let listingDevicesMessage = chalk("Listing Devices on your machine...")
      .backgroundWhite()
      .cyan()

    print(listingDevicesMessage)
    print(simulatorControl.listDevices())
  }
}
