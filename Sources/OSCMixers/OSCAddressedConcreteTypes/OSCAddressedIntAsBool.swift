import OSCKitCore
import Combine

// An OSC address that sends/receives a single Int value of 1 or 0
// to wrap a boolean value
public class OSCAddressedIntAsBool: OSCAddressedConcreteValue {
  private var cancellables = Set<AnyCancellable>()
  private let oscValues: OSCAddressedValues

  let onChange = PassthroughSubject<Bool, Never>()

  public var value: Bool = false {
    willSet(newValue) {
      if newValue != value {
        try? oscValues.sendValues([newValue ? 1 : 0])
        onChange.send(newValue)
      }
    }
  }

  required init(address: String, connection: MixerConnection) {
    oscValues = OSCAddressedValues(address, on: connection)
    oscValues.onReceived
      .map({ values in values[0] as! Int32 == 1 })
      .assign(to: \.value, on: self)
      .store(in: &cancellables)
  }
  
  public func requestValueUpdate() -> Void {
    try? oscValues.requestValues()
  }
}
