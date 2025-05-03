// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Slides",
  platforms: [.macOS(.v12)],
  products: [
    .library(
      name: "Interfaces",
      targets: ["Interfaces"]
    ),
    .library(
      name: "Potatotips0527",
      targets: ["Potatotips0527"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/mtj0928/SlideKit", from: "0.5.0")
  ],
  targets: [
    .target(
      name: "Interfaces",
      dependencies: [
        .product(name: "SlideKit", package: "SlideKit")
      ]
    ),
    .target(
      name: "Potatotips0527",
      dependencies: [
        "Interfaces",
        .product(name: "SlideKit", package: "SlideKit"),
      ]
    ),
  ]
)
