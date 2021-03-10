import Foundation
import OpenCCBridge

/// OpenCC Converter
public struct Converter {

        private let converter: BridgeConverter

        /// OpenCC Converter
        /// - Parameter conversion: Converter Conversion
        /// - Throws: ConverterError
        public init(_ conversion: Conversion) throws {
                let segmentation = try DictionaryHandler.segmentation(conversion: conversion)
                var chain = try DictionaryHandler.conversionChain(conversion: conversion)
                converter = createConverter("OpenCCLite", segmentation, &chain, chain.count)
        }

        /// delete
        public func destroy() {
                destroyConverter(converter)
        }

        /// Convert text
        /// - Parameter text: Original text
        /// - Returns: Converted text
        public func convert(_ text: String) -> String {
                let stlString = converterConvert(converter, text)!
                defer { destroySTLString(stlString) }
                return String(utf8String: utf8StringFrom(stlString))!
        }
}
extension Converter {
        public enum Conversion {
                case hkStandard
                case twStandard
                case simplify

                fileprivate var segmentationDictName: String {
                        switch self {
                        case .hkStandard:
                                return "HKVariants"
                        case .twStandard:
                                return "TWVariants"
                        case .simplify:
                                return "TSPhrases"
                        }
                }
                fileprivate var conversionDictNameChain: [[String]] {
                        switch self {
                        case .hkStandard:
                                return [["HKVariants"]]
                        case .twStandard:
                                return [["TWVariants"]]
                        case .simplify:
                                return [["TSPhrases", "TSCharacters"]]
                        }
                }
        }
}
private struct DictionaryHandler {
        private static func dict(_ name: String) throws -> BridgeDict {
                guard let path: String = Bundle.module.path(forResource: name, ofType: "ocd2") else {
                        throw ConverterError.fileNotFound
                }
                guard let marisaDict: BridgeDict = createMarisaDict(path) else {
                        throw ConverterError(bridgeError)
                }
                return marisaDict
        }
        static func segmentation(conversion: Converter.Conversion) throws -> BridgeDict {
                let dictName = conversion.segmentationDictName
                return try dict(dictName)
        }
        static func conversionChain(conversion: Converter.Conversion) throws -> [BridgeDict] {
                return try conversion.conversionDictNameChain.compactMap { names in
                        switch names.count {
                        case 0:
                                return nil
                        case 1:
                                return try dict(names.first!)
                        default:
                                var dicts = try names.map(dict)
                                return createDictGroup(&dicts, dicts.count)
                        }
                }
        }
}

private enum ConverterError: Swift.Error {

        case fileNotFound,
             invalidFormat,
             invalidTextDictionary,
             invalidUTF8,
             unknown

        init(_ code: BridgeError) {
                switch code {
                case .fileNotFound:
                        self = .fileNotFound
                case .invalidFormat:
                        self = .invalidFormat
                case .invalidTextDictionary:
                        self = .invalidTextDictionary
                case .invalidUTF8:
                        self = .invalidUTF8
                case .unknown:
                        self = .unknown
                @unknown default:
                        self = .unknown
                }
        }
}
