// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Slides",
  platforms: [.iOS(.v26), .macOS(.v26), .tvOS(.v26), .visionOS(.v26)],
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
      name: "CreateSpatialPhoto",
      targets: ["CreateSpatialPhoto"]
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
    .library(
      name: "ExternalStorage",
      targets: ["ExternalStorage"]
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
        "CreateSpatialPhoto",
        "Potatotips0527",
        "SwiftUITransition",
        "visionOSMeetupVol10",
        "ExternalStorage",
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
      name: "CreateSpatialPhoto",
      dependencies: [
        "Common",
        "Exhivision",
        "SelfIntroduce",
        .product(name: "SlideKit", package: "SlideKit"),
        .product(name: "YouTubePlayerKit", package: "YouTubePlayerKit"),
      ],
      resources: [
        .process("SyncCamera.mov")
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
    .target(
      name: "ExternalStorage",
      dependencies: [
        "Common",
        "SelfIntroduce",
        .product(name: "SlideKit", package: "SlideKit"),
      ],
      resources: [
        .process("kyu.mov")
      ]
    ),
  ]
)
