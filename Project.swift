import ProjectDescription

let app = Target.target(
  name: "ColorWheel",
  destinations: [.iPhone, .iPad, .mac],
  product: .app,
  bundleId: "com.gaetanomatonti.ColorWheel",
  deploymentTargets: .multiplatform(iOS: "18.0", macOS: "15.0"),
  infoPlist: .extendingDefault(
    with: [
      "UILaunchScreen": [:]
    ]
  ),
  sources: [
    "ColorWheel/**/*.swift",
    "ColorWheel/**/*.metal"
  ],
  resources: [
    "ColorWheel/**/*.xcassets"
  ],
  dependencies: [
    .external(name: "Vectors")
  ]
)

let project = Project(
  name: "ColorWheel",
  organizationName: "Gaetano Matonti",
  options: .options(
    disableBundleAccessors: true,
    textSettings: .textSettings(
      usesTabs: false,
      tabWidth: 2
    )
  ),
  targets: [
    app
  ],
  resourceSynthesizers: []
)
