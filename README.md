# OSCMixers

Swift module for interacting with mixing consoles via OSC.

This is basically a domain-specific abstraction on top of [orchetect/OSCKit](https://github.com/orchetect/OSCKit).

It is extremely experimental. I don't know what I'm doing.

## Features

* Asynchronously obtain basic mixer info with `let mixer = XRMixer(host: "0.0.0.0")`
* Control a mute group with `XRMuteGroup(1, on: mixer)`
* Both of those classes conform to `ObservableObject` for easy integration with SwiftUI

* _Planned:_
  * `async/await` for getting a value once
  * Other "components" like channels (fader, pan, etc.)

## Mixer Support

* Behringer XR18
  * Probably also the XR12 and XR16, but that's untested as I don't have them
* _Planned_
  * Behringer XR32
  * Midas equivalents to above
