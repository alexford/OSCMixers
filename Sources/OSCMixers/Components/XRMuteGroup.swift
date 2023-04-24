import Combine

public class XRMuteGroup: ObservableObject {
    let mixer: XRMixer
    private let addressedValue: OSCAddressedIntAsBool
    private var cancellables = Set<AnyCancellable>()

    @Published public var muted: Bool = false

    public let name: String

    public init(_ number: Int, on mixer: XRMixer) {
        self.mixer = mixer
        self.name = "Mute Group \(number)"

        addressedValue = OSCAddressedIntAsBool(
            address: "/config/mute/\(number)",
            connection: mixer.connection
        )

        addressedValue.onChange.assign(to: &$muted)
        addressedValue.requestValueUpdate()
    }

    public func toggle() {
        addressedValue.value = !addressedValue.value
    }
    
    public func mute() {
        addressedValue.value = true
    }
    
    public func unmute() {
        addressedValue.value = false
    }
}
