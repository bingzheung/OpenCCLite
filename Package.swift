// swift-tools-version:5.3

import PackageDescription

let package = Package(
        name: "OpenCCLite",
        platforms: [.iOS(.v13), .macOS(.v11)],
        products: [
                .library(name: "OpenCCLite", targets: ["OpenCCLite"])
        ],
        targets: [
                .target(
                        name: "OpenCCLite",
                        dependencies: ["OpenCCBridge"],
                        resources: [.process("Resources")]
                ),
                .testTarget(
                        name: "OpenCCLiteTests",
                        dependencies: ["OpenCCLite"]
                ),
                .target(
                        name: "OpenCCBridge",
                        exclude: [
                                "deps/google-benchmark",
                                "deps/gtest-1.11.0",
                                "deps/marisa-0.2.6/AUTHORS",
                                "deps/marisa-0.2.6/CMakeLists.txt",
                                "deps/marisa-0.2.6/COPYING.md",
                                "deps/marisa-0.2.6/README.md",
                                "deps/pybind11-2.5.0",
                                "deps/rapidjson-1.1.0",
                                "deps/tclap-1.2.2",
                                "src/BinaryDictTest.cpp",
                                "src/CMakeLists.txt",
                                "src/CmdLineOutput.hpp",
                                "src/Config.cpp",
                                "src/Config.hpp",
                                "src/ConfigTest.cpp",
                                "src/ConfigTestBase.hpp",
                                "src/ConversionChainTest.cpp",
                                "src/ConversionTest.cpp",
                                "src/DartsDictTest.cpp",
                                "src/DictGroupTest.cpp",
                                "src/DictGroupTestBase.hpp",
                                "src/MarisaDictTest.cpp",
                                "src/MaxMatchSegmentationTest.cpp",
                                "src/PhraseExtractTest.cpp",
                                "src/README.md",
                                "src/SerializedValuesTest.cpp",
                                "src/SimpleConverter.cpp",
                                "src/SimpleConverter.hpp",
                                "src/SimpleConverterTest.cpp",
                                "src/TestUtils.hpp",
                                "src/TestUtilsUTF8.hpp",
                                "src/TextDictTest.cpp",
                                "src/TextDictTestBase.hpp",
                                "src/UTF8StringSliceTest.cpp",
                                "src/UTF8UtilTest.cpp",
                                "src/benchmark",
                                "src/py_opencc.cpp",
                                "src/tools"
                        ],
                        sources: [
                                "bridge.cpp",
                                "src",
                                "deps/marisa-0.2.6"
                        ],
                        cxxSettings: [
                                .headerSearchPath("src"),
                                .headerSearchPath("deps/darts-clone"),
                                .headerSearchPath("deps/marisa-0.2.6/include"),
                                .headerSearchPath("deps/marisa-0.2.6/lib"),
                                .define("ENABLE_DARTS")
                        ]
                )
        ],
        cxxLanguageStandard: .gnucxx14
)
