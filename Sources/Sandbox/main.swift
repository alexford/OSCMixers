import OSCMixers
import Foundation

print("Sandbox starting")

let xr = XRMixer(host: "192.168.1.141")

xr.connect()

xr.xremote()
xr.info()
xr.status()

// var faderStep = 1
// let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//     print("Sending fader")
//     xr.testFader(Float(faderStep)/10.0)
//     faderStep += 1
//     if faderStep > 10 {
//         faderStep = 1
//     }
// }

dispatchMain()
