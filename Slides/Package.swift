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
      name: "Interfaces",
      targets: ["Interfaces"]
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
    .package(url: "https://github.com/fromkk/SlideKit", branch: "main")
  ],
  targets: [
    .target(
      name: "AboutSkip",
      dependencies: [
        "Interfaces",
        "SelfIntroduce",
        .product(name: "SlideKit", package: "SlideKit"),
      ]
    ),
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
        "SelfIntroduce",
        .product(name: "SlideKit", package: "SlideKit"),
      ]
    ),
    .target(
      name: "SelfIntroduce",
      dependencies: [
        .product(name: "SlideKit", package: "SlideKit")
      ]
    ),
    .target(
      name: "visionOSMeetupVol10",
      dependencies: [
        "Interfaces",
        "SelfIntroduce",
        .product(name: "SlideKit", package: "SlideKit"),
      ]
    ),
  ]
)
