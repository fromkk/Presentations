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
      name: "Common",
      targets: ["Common"]
    ),
    .library(
      name: "Exhivision",
      targets: ["Exhivision"]
    ),
    .library(
      name: "MitumerundesuSpatialPhoto",
      targets: ["MitumerundesuSpatialPhoto"]
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
      name: "SwiftUITransition",
      targets: ["SwiftUITransition"]
    ),
    .library(
      name: "visionOSMeetupVol10",
      targets: ["visionOSMeetupVol10"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/mtj0928/SlideKit.git", from: "0.6.1"),
    .package(url: "https://github.com/SvenTiigi/YouTubePlayerKit.git", from: "2.0.0"),
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
        "MitumerundesuSpatialPhoto",
        "Potatotips0527",
        "SwiftUITransition",
        "visionOSMeetupVol10",
      ]
    ),
    .target(
      name: "Common",
      dependencies: [
        .product(name: "SlideKit", package: "SlideKit")
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
      name: "MitumerundesuSpatialPhoto",
      dependencies: [
        "Common",
        "Exhivision",
        "SelfIntroduce",
        .product(name: "SlideKit", package: "SlideKit"),
        .product(name: "YouTubePlayerKit", package: "YouTubePlayerKit"),
      ]
    ),
    .target(
      name: "Potatotips0527",
      dependencies: [
        "Common",
        "Exhivision",
        "SelfIntroduce",
        .product(name: "SlideKit", package: "SlideKit"),
      ],
      resources: [
        .process("exhivision_spatial_photo.mov")
      ]
    ),
    .target(
      name: "SelfIntroduce",
      dependencies: [
        "Common",
        .product(name: "SlideKit", package: "SlideKit"),
      ]
    ),
    .target(
      name: "SwiftUITransition",
      dependencies: [
        "Common",
        "Exhivision",
        "SelfIntroduce",
        .product(name: "SlideKit", package: "SlideKit"),
      ]
    ),
    .target(
      name: "visionOSMeetupVol10",
      dependencies: [
        "Common",
        "Exhivision",
        "SelfIntroduce",
        .product(name: "SlideKit", package: "SlideKit"),
      ]
    ),
  ]
)
