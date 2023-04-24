// The Swift Programming Language
// https://docs.swift.org/swift-book

import OSCKit

public class MixerConnection {
    private let host: String
    private let port: UInt16
    public let socket: OSCSocket
    public private(set) var isConnected: Bool = false
    private let addressSpace = OSCAddressSpace()

    public init(host: String, port: UInt16) {
        self.host = host
        self.port = port
    
        socket = OSCSocket(
            remoteHost: host,
            remotePort: port
        )
    }

    public func connect() {
        do {
            try socket.start()
            socket.setHandler { message, timeTag in
                print("RECEIVED:",message)
                self.addressSpace.dispatch(message)
            }
            self.isConnected = true
        } catch {
            print("Connection failed: \(error)")
        }
    }
    
    public func disconnect() {
        socket.stop()
        print("disconnected a connection")
    }

    public func setReceiveHandler(_ address: String, _ handler: @escaping (_ values: OSCValues) -> Void) {
        print("Registering at ",address)
        self.addressSpace.register(localAddress: address, block: handler)
    }

    final func sendMessage(_ address: String, values: [any OSCValue] = []) throws -> Void  {
        if !isConnected {
            connect()
        }

        let message = OSCMessage(address, values: values)

        do {
            try socket.send(message)
            print("SENT:",message, String(describing: socket.remoteHost))
        } catch {
            print("Unexpected error: \(error).")
            throw OSCMixerSendError.Unknown(originalError: error)
        }
    }

    deinit {
        print("deinit a connection")
        disconnect()
    }
}

extension MixerConnection: Equatable {
    static public func == (lhs: MixerConnection, rhs: MixerConnection) -> Bool {
        return
            lhs.host == rhs.host &&
            lhs.port == rhs.port
    }
}
