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
                                "src/BinaryDict.hpp",
                                "src/BinaryDictTest.cpp",
                                "src/CMakeLists.txt",
                                "src/CmdLineOutput.hpp",
                                "src/Common.hpp",
                                "src/Config.cpp",
                                "src/Config.hpp",
                                "src/ConfigTest.cpp",
                                "src/ConfigTestBase.hpp",
                                "src/Conversion.hpp",
                                "src/ConversionChain.hpp",
                                "src/ConversionChainTest.cpp",
                                "src/ConversionTest.cpp",
                                "src/Converter.hpp",
                                "src/DartsDict.hpp",
                                "src/DartsDictTest.cpp",
                                "src/Dict.hpp",
                                "src/DictConverter.hpp",
                                "src/DictEntry.hpp",
                                "src/DictGroup.hpp",
                                "src/DictGroupTest.cpp",
                                "src/DictGroupTestBase.hpp",
                                "src/Exception.hpp",
                                "src/Export.hpp",
                                "src/Lexicon.hpp",
                                "src/MarisaDict.hpp",
                                "src/MarisaDictTest.cpp",
                                "src/MaxMatchSegmentation.hpp",
                                "src/MaxMatchSegmentationTest.cpp",
                                "src/Optional.hpp",
                                "src/PhraseExtract.hpp",
                                "src/PhraseExtractTest.cpp",
                                "src/README.md",
                                "src/Segmentation.hpp",
                                "src/Segments.hpp",
                                "src/SerializableDict.hpp",
                                "src/SerializedValues.hpp",
                                "src/SerializedValuesTest.cpp",
                                "src/SimpleConverter.cpp",
                                "src/SimpleConverter.hpp",
                                "src/SimpleConverterTest.cpp",
                                "src/TestUtils.hpp",
                                "src/TestUtilsUTF8.hpp",
                                "src/TextDict.hpp",
                                "src/TextDictTest.cpp",
                                "src/TextDictTestBase.hpp",
                                "src/UTF8StringSlice.hpp",
                                "src/UTF8StringSliceTest.cpp",
                                "src/UTF8Util.hpp",
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
                        cSettings: [
                                .headerSearchPath("src"),
                                .headerSearchPath("deps/marisa-0.2.6/lib"),
                                .headerSearchPath("deps/marisa-0.2.6/include"),
                                .headerSearchPath("deps/darts-clone"),
                                .define("ENABLE_DARTS")
                        ],
                        cxxSettings: [
                                .headerSearchPath("src"),
                                .headerSearchPath("deps/marisa-0.2.6/lib"),
                                .headerSearchPath("deps/marisa-0.2.6/include"),
                                .headerSearchPath("deps/darts-clone"),
                                .define("ENABLE_DARTS")
                        ]
                )
        ],
        cLanguageStandard: .gnu11,
        cxxLanguageStandard: .gnucxx14
)
