# Mica

A collection of shortcuts that I use on my Mac to avoid remebering the system commands

**Warning**: The Code in this codebase is not exemplary; do not replciate, copy, or extend any of the patterns you see here. Doing so will result in harm to your future self.

## Setup

This project was set up using swift pacakge tooling

i.e.

```
swift package init --type executable
```

in accordance to the [getting started guide](https://www.swift.org/getting-started/)

### Building

To build the package run the following command

```
swift build
```

### Running

To run the executable run the following command

```
swift run mica
```

### Installing

To install the package on your machine perform the following steps

Build for release

```
swift build -c release
```

Copy the executable to your `/usr/local/bin` 
**Note**: This assumes that `/usr/local/bin` is in your path

```
sudo cp .build/release/mica /usr/local/bin 
```

verify that `mica` was installed correctly

```
% which mica
/usr/local/bin/mica
```

## Usage

Default behavior

```
% mica 
Usage:

    $ mica

Commands:

    + list-devices - list all the devices and runtimes available on your mac
    + start-simulator - start specified simulator device

```

### List Devices

Usage

e.g.
```
mica devices-list
```

A wrapper for

```
xcrun simctl list
```

### Start Simulator

Usage

e.g.
```
mica simulator-start iPhone 14
```

A wrapper for

```
open -a Simulator --args -CurrentDeviceUDID {UDID}
```

where the UDID is matched from the input you pass in greped against teh shutdown devices in your devices list