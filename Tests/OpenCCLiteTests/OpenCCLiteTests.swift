import XCTest
@testable import OpenCCLite

final class OpenCCLiteTests: XCTestCase {
        func testHKStandard() {
                let converter: Converter = try! Converter(.hkStandard)
                defer { converter.destroy() }
                let converted: String = converter.convert("臺戶")
                XCTAssertEqual(converted, "台户")
        }
        func testTWStandard() {
                let converter: Converter = try! Converter(.twStandard)
                defer { converter.destroy() }
                let converted: String = converter.convert("牀峯")
                XCTAssertEqual(converted, "床峰")
        }
        func testSimplify() {
                let converter: Converter = try! Converter(.simplify)
                defer { converter.destroy() }
                let converted: String = converter.convert("發髮")
                XCTAssertEqual(converted, "发发")
        }
}
