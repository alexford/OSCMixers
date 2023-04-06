// The Swift Programming Language
// https://docs.swift.org/swift-book

import OSCKit

public class Mixer {
    let host: String
    let port: UInt16
    let client: OSCClient = OSCClient()
    let server: OSCServer
    
    public init(host: String, port: UInt16 = 10024) {
        self.host = host
        self.port = port
        self.server = OSCServer(port: port)
        
        self.server.setHandler { message, timeTag in
            print(message, "with time tag:", timeTag)
        }
        
        do {
            try self.server.start()
        } catch {
            print("Unexpected error starting server: \(error).")
        }
    }
    
    deinit {
        self.server.stop()
    }
    
    final func sendMessage(_ address: String, values: [any OSCValue] = []) -> Void {
        let message = OSCMessage(address, values: values)
        print(message)
        

        do {
            try client.send(
                message,
                to: self.host,
                port: self.port
            )
        } catch {
            print("Unexpected error: \(error).")
        }
    }
}
