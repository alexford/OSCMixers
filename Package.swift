// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OSCMixers",
    
    platforms: [.macOS(.v11), .iOS(.v11), .tvOS(.v11)],
    
    products: [
        .library(
            name: "OSCMixers",
            targets: ["OSCMixers"]),
        .executable(name: "Sandbox", targets: ["Sandbox"]),
    ],
    
    dependencies: [
        .package(url: "https://github.com/orchetect/OSCKit", from: "0.5.0")
    ],
    
    targets: [
        .executableTarget(
            name: "Sandbox",
            dependencies: ["OSCMixers"]),
        .target(
            name: "OSCMixers",
            dependencies: ["OSCKit"]),
        .testTarget(
            name: "OSCMixersTests",
            dependencies: ["OSCMixers"]),
    ]
)
