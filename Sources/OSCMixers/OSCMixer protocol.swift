// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import Combine
import OSCKit

public protocol OSCMixer: ObservableObject, Equatable {
    var connection: MixerConnection { get }

    var model: String { get }
    var name: String { get }
    var version: String { get }
    var isActive: Bool { get }
    var connectionProblem: Bool { get }

    init(host: String)
    
    func connect() -> Void
    func disconnect() -> Void
}
