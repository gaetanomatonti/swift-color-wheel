// swift-tools-version: 5.9
import PackageDescription

#if TUIST
import ProjectDescription

let packageSettings = PackageSettings(
  productTypes: [
    "Vectors": .framework,
  ]
)
#endif

let package = Package(
  name: "PackageName",
  dependencies: [
    .package(url: "git@github.com:gaetanomatonti/swift-vectors.git", branch: "develop"),
  ]
)
