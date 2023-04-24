import Combine

protocol OSCAddressedConcreteValue {
  associatedtype ValueType
  var value: ValueType { get set }
  
  var onChange: PassthroughSubject<ValueType, Never> { get }
  
  init(address: String, connection: MixerConnection)
  
  func requestValueUpdate() -> Void
}
