public final class XRMixer: OSCMixer {
    let XR_MIXER_PORT: UInt16 = 10024

    var model: String?
    var name: String?
    var version: String?

    public init(host: String) {
        super.init(host: host, port: XR_MIXER_PORT)
    }
    
    override public func connect() {
        super.connect()
        // trigger info message
        // start /xremote timer
    }

    public func info() {
        self.sendMessage("/xinfo")
    }
    
    public func status() {
        self.sendMessage("/status")
    }
    
    public func xremote() {
        self.sendMessage("/xremote")
    }
    
    public func testFader(_ position: Float) {
        self.sendMessage("/ch/01/mix/fader", values: [position])
    }
}
