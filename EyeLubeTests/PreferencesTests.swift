// Add tests for color/opacity features 

import XCTest
@testable import EyeLube

class PreferencesTests: XCTestCase {
    var storage: PreferencesStorage!
    
    override func setUp() {
        super.setUp()
        storage = PreferencesStorage.shared
        // Reset to defaults before each test
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    func testColorPersistence() {
        // Test color storage
        let testColor = NSColor(red: 0.5, green: 0.2, blue: 0.8, alpha: 0.7)
        storage.fadeColor = testColor
        
        let newStorage = PreferencesStorage()
        XCTAssertEqual(newStorage.fadeColor, testColor, "Color should persist between launches")
    }
    
    func testOpacityRange() {
        // Test boundary conditions
        storage.maxOpacity = 1.0
        XCTAssertEqual(storage.maxOpacity, 1.0, "Should allow maximum opacity")
        
        storage.maxOpacity = 0.0
        XCTAssertGreaterThan(storage.maxOpacity, 0.0, "Should enforce minimum opacity")
    }
    
    func testSystemPreferencesSync() {
        // Mock system preferences
        let systemDefaults = UserDefaults(suiteName: "com.apple.systempreferences")!
        systemDefaults.set(2.5, forKey: "fadeDuration")
        
        storage.loadSystemDefaults()
        XCTAssertEqual(storage.fadeDuration, 2.5, "Should sync with system preferences")
    }
    
    func testFadeDurationBoundaries() {
        // Test minimum boundary
        storage.fadeDuration = 0.1
        XCTAssertEqual(storage.fadeDuration, 0.5, "Should enforce minimum 0.5s duration")
        
        // Test maximum boundary
        storage.fadeDuration = 10.0
        XCTAssertEqual(storage.fadeDuration, 5.0, "Should enforce maximum 5.0s duration")
    }
    
    func testColorEncoding() {
        let testColor = NSColor(calibratedRed: 0.2, green: 0.4, blue: 0.6, alpha: 0.8)
        storage.fadeColor = testColor
        
        if let data = UserDefaults.standard.data(forKey: "fadeColor"),
           let color = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSColor.self, from: data) {
            XCTAssertEqual(color, testColor, "Color should encode/decode properly")
        } else {
            XCTFail("Color encoding failed")
        }
    }
    
    func testSystemPreferencesIntegration() {
        let systemDefaults = UserDefaults(suiteName: "com.apple.systempreferences")!
        systemDefaults.set(3.0, forKey: "fadeDuration")
        systemDefaults.synchronize()
        
        storage.loadSystemDefaults()
        XCTAssertEqual(storage.fadeDuration, 3.0, "Should sync with system preferences")
        
        // Test fallback when system preference missing
        systemDefaults.removeObject(forKey: "fadeDuration")
        storage.loadSystemDefaults()
        XCTAssertEqual(storage.fadeDuration, 1.0, "Should use default when system pref missing")
    }
    
    // Expand test coverage for preference persistence
    // Add tests for:
    // - Fade duration boundary cases
    // - Color preference encoding/decoding
    // - System preference integrations
} 