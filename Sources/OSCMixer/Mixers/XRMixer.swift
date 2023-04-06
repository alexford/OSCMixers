public final class XRMixer: Mixer {
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
