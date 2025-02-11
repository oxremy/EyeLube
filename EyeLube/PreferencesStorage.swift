import Foundation
import Combine
import AppKit

class PreferencesStorage: ObservableObject {
    static let shared = PreferencesStorage()
    
    private enum Keys {
        static let fadeDuration = "fadeDuration"
        static let maxOpacity = "maxOpacity"
        static let colorRed = "colorRed"
        static let colorGreen = "colorGreen"
        static let colorBlue = "colorBlue"
        static let colorAlpha = "colorAlpha"
    }
    
    @Published var fadeDuration: TimeInterval {
        didSet { UserDefaults.standard.set(fadeDuration, forKey: Keys.fadeDuration) }
    }
    
    @Published var maxOpacity: CGFloat {
        didSet { UserDefaults.standard.set(Double(maxOpacity), forKey: Keys.maxOpacity) }
    }
    
    @Published var fadeColor: NSColor {
        didSet {
            // Convert to RGB color space before saving components
            let rgbColor = fadeColor.usingColorSpace(.sRGB) ?? fadeColor
            UserDefaults.standard.set(rgbColor.redComponent, forKey: Keys.colorRed)
            UserDefaults.standard.set(rgbColor.greenComponent, forKey: Keys.colorGreen)
            UserDefaults.standard.set(rgbColor.blueComponent, forKey: Keys.colorBlue)
            UserDefaults.standard.set(rgbColor.alphaComponent, forKey: Keys.colorAlpha)
        }
    }
    
    @Published var launchAtLogin: Bool {
        didSet {
            UserDefaults.standard.set(launchAtLogin, forKey: "launchAtLogin")
        }
    }
    
    private init() {
        // Initialize ALL stored properties first
        self.fadeDuration = UserDefaults.standard.double(forKey: Keys.fadeDuration)
        self.maxOpacity = CGFloat(UserDefaults.standard.double(forKey: Keys.maxOpacity))
        
        // Color initialization with safe RGB conversion
        let red = UserDefaults.standard.double(forKey: Keys.colorRed)
        let green = UserDefaults.standard.double(forKey: Keys.colorGreen)
        let blue = UserDefaults.standard.double(forKey: Keys.colorBlue)
        let alpha = UserDefaults.standard.double(forKey: Keys.colorAlpha)
        
        let initialColor = NSColor(
            red: red.clamped(to: 0...1),
            green: green.clamped(to: 0...1),
            blue: blue.clamped(to: 0...1),
            alpha: alpha.clamped(to: 0...1)
        )
        
        // Convert to RGB color space if needed
        self.fadeColor = initialColor.usingColorSpace(.sRGB) ?? NSColor.black
        
        self.launchAtLogin = UserDefaults.standard.bool(forKey: "launchAtLogin")
        
        // THEN apply defaults
        if fadeDuration <= 0 {
            fadeDuration = 1.5
        }
        if maxOpacity <= 0 {
            maxOpacity = 0.8
        }
        if alpha == 0 {
            self.fadeColor = .black
        }
    }
}

// Add this extension for safe value clamping
extension Double {
    func clamped(to range: ClosedRange<Double>) -> Double {
        return min(max(self, range.lowerBound), range.upperBound)
    }
} 