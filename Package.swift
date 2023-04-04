// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OSCMixer",
    products: [
        .library(
            name: "OSCMixer",
            targets: ["OSCMixer"]),
    ],
    
    dependencies: [
        .package(url: "https://github.com/orchetect/OSCKit", from: "0.4.0")
    ],
    
    targets: [
        .target(
            name: "OSCMixer",
            dependencies: ["OSCKit"]),
        .testTarget(
            name: "OSCMixerTests",
            dependencies: ["OSCMixer"]),
    ]
)
