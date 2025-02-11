// New file for system preferences integration 
import Foundation
import AppKit
import ServiceManagement

class SystemPreferencesManager {
    static let shared = SystemPreferencesManager()
    
    private let preferencesDomain = "com.eyelube.preferences"
    
    func registerAsSystemPreferencesPane() {
        _ = Bundle.main.bundleIdentifier // Explicitly ignore unused value
        let url = URL(fileURLWithPath: "/System/Library/PreferencePanes/")
        
        // Create symlink to app's preference pane
        do {
            try FileManager.default.createSymbolicLink(
                at: url.appendingPathComponent("EyeLube.prefPane"),
                withDestinationURL: Bundle.main.bundleURL
            )
        } catch {
            print("Error creating preference pane link: \(error)")
        }
        
        // Register with system preferences
        NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:com.apple.preference")!)
    }
    
    func syncWithSystemPreferences() {
        DistributedNotificationCenter.default().addObserver(
            self,
            selector: #selector(preferencesChanged(_:)),
            name: NSNotification.Name(rawValue: "ApplePreferencesChangedNotification"),
            object: nil
        )
    }
    
    @objc private func preferencesChanged(_ notification: Notification) {
        // Handle system preference changes
        PreferencesStorage.shared.loadSystemDefaults()
    }
    
    // MARK: - Launch at Login
    func setLaunchAtLogin(enabled: Bool) {
        do {
            try SMAppService().register()
        } catch {
            print("Launch at login registration failed: \(error)")
        }
    }
    
    // MARK: - Accessibility Permissions
    var hasAccessibilityPermissions: Bool {
        AXIsProcessTrustedWithOptions(
            [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: true] as CFDictionary
        )
    }
    
    // MARK: - System Appearance Sync
    func syncWithSystemAppearance() {
        NotificationCenter.default.addObserver(
            forName: Notification.Name(rawValue: "NSApplicationEffectiveAppearanceDidChangeNotification"),
            object: nil,
            queue: .main) { _ in
                PreferencesStorage.shared.updateForSystemAppearance()
            }
    }
}

extension PreferencesStorage {
    func loadSystemDefaults() {
        let systemDefaults = UserDefaults(suiteName: "com.apple.systempreferences")
        // Sync relevant system settings
        if let systemFade = systemDefaults?.double(forKey: "fadeDuration") {
            self.fadeDuration = systemFade
        }
    }
    
    func updateForSystemAppearance() {
        let isDarkMode = NSApp.effectiveAppearance.name == .darkAqua
        self.fadeColor = isDarkMode ? .black : NSColor(white: 0.2, alpha: 1.0)
    }
} 