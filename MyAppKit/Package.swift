// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyAppKit",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MyAppColorKit",
            targets: ["MyAppColorKit"]),
        
        .library(
            name: "MyAppFontKit",
            targets: ["MyAppFontKit"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MyAppColorKit",
            dependencies: ["MyAppFontKit"]),
        .testTarget(
            name: "MyAppColorKitTests",
            dependencies: ["MyAppColorKit"]),
        
        .target(
            name: "MyAppFontKit",
            dependencies: []),
        .testTarget(
            name: "MyAppFontKitTests",
            dependencies: ["MyAppFontKit"]),
        
    ]
    
)

////.package(name: "MyLibrary", path: "/Users/ankitnigam/Documents/SourceCode/Framework_Repo/MyLibrary")
/////"MyLibrary"
