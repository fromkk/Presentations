// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Slides",
  platforms: [.iOS(.v18), .macOS(.v15), .tvOS(.v16), .visionOS(.v2)],
  products: [
    .library(
      name: "AboutSkip",
      targets: ["AboutSkip"]
    ),
    .library(
      name: "App",
      targets: ["App"]
    ),
    .library(
      name: "Exhivision",
      targets: ["Exhivision"]
    ),
    .library(
      name: "Common",
      targets: ["Common"]
    ),
    .library(
      name: "Potatotips0527",
      targets: ["Potatotips0527"]
    ),
    .library(
      name: "SelfIntroduce",
      targets: ["SelfIntroduce"]
    ),
    .library(
      name: "visionOSMeetupVol10",
      targets: ["visionOSMeetupVol10"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/fromkk/SlideKit.git", branch: "main")
  ],
  targets: [
    .target(
      name: "AboutSkip",
      dependencies: [
        "Common",
        "SelfIntroduce",
        .product(name: "SlideKit", package: "SlideKit"),
      ]
    ),
    .target(
      name: "App",
      dependencies: [
        "AboutSkip",
        "Potatotips0527",
        "visionOSMeetupVol10",
      ]
    ),
    .target(
      name: "Exhivision",
      dependencies: [
        .product(name: "SlideKit", package: "SlideKit")
      ],
      resources: [
        .process("exhivision.mov")
      ]
    ),
    .target(
      name: "Common",
      dependencies: [
        .product(name: "SlideKit", package: "SlideKit")
      ]
    ),
    .target(
      name: "Potatotips0527",
      dependencies: [
        "Exhivision",
        "Common",
        "SelfIntroduce",
        .product(name: "SlideKit", package: "SlideKit"),
      ]
    ),
    .target(
      name: "SelfIntroduce",
      dependencies: [
        "Common",
        .product(name: "SlideKit", package: "SlideKit")
      ]
    ),
    .target(
      name: "visionOSMeetupVol10",
      dependencies: [
        "Exhivision",
        "Common",
        "SelfIntroduce",
        .product(name: "SlideKit", package: "SlideKit"),
      ]
    ),
  ]
)
