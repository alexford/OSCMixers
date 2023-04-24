import Combine
import Foundation

public class XRMixer: OSCMixer {
    let XR_MIXER_PORT: UInt16 = 10024

    public let connection: MixerConnection

    @Published public private(set) var model: String = "Unknown XR Mixer"
    @Published public private(set) var name: String = "Unnamed XR Mixer"
    @Published public private(set) var version: String = "Unknown Version"
    @Published public private(set) var isActive: Bool = false
    @Published public private(set) var connectionProblem: Bool = false

    private var connectionInvalidTimer: Timer?
    private var xremoteTimer: Timer?

    required public init(host: String) {
        self.connection = MixerConnection(host: host, port: XR_MIXER_PORT)

        // TODO: move these handlers somewhere else?
        self.connection.setReceiveHandler("/status") { values in
            guard let status = values[0] as? String else { return }
            self.isActive = status == "active"

            self.connectionInvalidTimer?.invalidate()
            self.connectionProblem = false
            self.listenForUpdates()
        }
        
        self.connection.setReceiveHandler("/xinfo") { values in
            guard values.count == 4 else { return }
            
            let (_, newName, newModel, newVersion) = try! values.masked(String.self, String.self, String.self, String.self)
            self.name = newName
            self.model = newModel
            self.version = newVersion
        }
    }

    public func connect() {
        self.connection.connect()

        requestStatus()
        requestInfo()
    }

    public func disconnect() {
        self.connection.disconnect()
        self.connectionInvalidTimer?.invalidate()
        self.xremoteTimer?.invalidate()
        self.connectionProblem = false
        self.isActive = false
    }

    func requestInfo() {
        try! self.connection.sendMessage("/xinfo")
    }
    
    func requestStatus() {
        try! self.connection.sendMessage("/status")
        self.startConnectionInvalidTimer()
    }
    
    func startConnectionInvalidTimer() {
        self.connectionInvalidTimer = Timer(timeInterval: 2.0, repeats: false) { _ in
            print("Didn't hear back from /status message")
            self.connectionProblem = true
            self.isActive = false

            // Keep trying?
            self.requestStatus()
        }
        self.connectionInvalidTimer?.tolerance = 1.0
        RunLoop.current.add(self.connectionInvalidTimer!, forMode: .common)
    }
    
        
    func listenForUpdates() {
        self.xremote()
        self.xremoteTimer?.invalidate()
        self.xremoteTimer = Timer(timeInterval: 8, repeats: true) { _ in
            self.xremote()
        }
        self.xremoteTimer?.tolerance = 1.0
        RunLoop.current.add(self.xremoteTimer!, forMode: .common)
    }
    
    func xremote() {
        try! self.connection.sendMessage("/xremote")
    }
}

extension XRMixer: Equatable {
    static public func == (lhs: XRMixer, rhs: XRMixer) -> Bool {
        return lhs.connection == rhs.connection
    }
}
