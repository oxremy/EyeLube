import SwiftUI

class PreferencesWindowController: NSWindowController {
    static let shared = PreferencesWindowController()
    
    init() {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 420, height: 320),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )
        window.title = "EyeLube Preferences"
        window.contentView = NSHostingView(rootView: PreferencesView())
        window.center()
        super.init(window: window)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        showWindow(nil)
        NSApp.activate(ignoringOtherApps: true)
        window?.makeKeyAndOrderFront(nil)
    }
    
    @IBAction func fadeDurationChanged(_ sender: NSTextField) {
        let clampedValue = min(max(sender.doubleValue, 0.5), 10.0)
        Preferences.shared.fadeDuration = clampedValue
    }
} 