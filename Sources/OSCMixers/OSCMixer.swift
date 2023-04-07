// The Swift Programming Language
// https://docs.swift.org/swift-book

import OSCKit
import Foundation

public class OSCMixer {
    public let peer: OSCPeer
    public private(set) var isConnected: Bool = false

    public init(host: String, port: UInt16) {
        self.peer = OSCPeer(
            host: host,
            remotePort: port
        )
    }

    public func connect() {
        do {
            try self.peer.start()
            self.peer.setHandler { message, timeTag in
                print(message, "received with time tag:", timeTag)
            }
            self.isConnected = true
        } catch {
            print("Connection to mixer failed: \(error)")
        }
    }

    final func sendMessage(_ address: String, values: [any OSCValue] = []) -> Void {
        let message = OSCMessage(address, values: values)

        do {
            try peer.send(message)
            print(message, "sent")
        } catch {
            print("Unexpected error: \(error).")
        }
    }

    deinit {
        self.peer.stop()
    }
}
