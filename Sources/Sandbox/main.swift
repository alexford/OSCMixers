import OSCMixers
import Foundation

print("Sandbox starting")

let xr = XRMixer(host: "192.168.1.141")

xr.connect()

// print("Making mutegroup")
// let group1 = XRMuteGroup(1, on: xr)

// print("Making binding")
// let binding = BooleanIntAddressBinding(address: "/config/mute/1", connection: xr.connection)

var faderStep = 1
let timer = Timer(timeInterval: 1.0, repeats: true) { timer in
    // print("Sending fader")
    // xr.testFader(Float(faderStep)/10.0)
    // faderStep += 1
    // if faderStep > 10 {
    //     faderStep = 1
    // }
    //group1.muted ? group1.unmute() : group1.mute()

    //binding.value = !binding.value
}

//dispatchMain()

RunLoop.current.add(timer, forMode: .common)
RunLoop.current.run()
