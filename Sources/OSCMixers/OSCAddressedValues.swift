import OSCKitCore
import Combine

final class OSCAddressedValues {
  var lastSentRawValues: OSCValues?

  var rawValues: OSCValues?

  let onReceived = PassthroughSubject<OSCValues, Never>()

  let connection: MixerConnection
  let address: String

  public init(_ address: String, on connection: MixerConnection) {
    self.connection = connection
    self.address = address
    
    self.connection.setReceiveHandler(self.address, self.receivedRawValues)
  }

  public func sendValues(_ values: OSCValues) throws {
    try self.connection.sendMessage(self.address, values: values)
  }
  
  public func requestValues() throws {
    try self.connection.sendMessage(self.address)
  }

  private func receivedRawValues(_ values: OSCValues) {
    self.rawValues = values
    onReceived.send(values)
  }
}
