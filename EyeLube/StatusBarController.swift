import AppKit
import SwiftUI

class StatusBarController: NSObject, ObservableObject {
    private var statusItem: NSStatusItem
    private var menu: NSMenu
    private let screenFader = ScreenFader()
    
    override init() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        menu = NSMenu()
        
        super.init()
        
        // Configure menu bar icon
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "circle.lefthalf.filled", accessibilityDescription: "EyeLube")
            button.setAccessibilityLabel("EyeLube Controls")
        }
        
        // Build menu items
        let fadeItem = NSMenuItem(
            title: L10n.menuFadeTitle,
            action: #selector(toggleFade),
            keyEquivalent: ""
        )
        fadeItem.target = self
        
        let prefsItem = NSMenuItem(
            title: L10n.menuPreferences,
            action: #selector(openPreferences),
            keyEquivalent: ","
        )
        prefsItem.target = self
        
        let quitItem = NSMenuItem(
            title: L10n.menuQuit,
            action: #selector(quitApp),
            keyEquivalent: "q"
        )
        quitItem.target = self
        
        menu.addItem(fadeItem)
        menu.addItem(prefsItem)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(quitItem)
        
        statusItem.menu = menu
    }
    
    @objc func toggleFade() {
        NSAnimationContext.runAnimationGroup { [weak self] context in
            context.duration = 0.3
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            self?.screenFader.toggleFade()
            self?.updateIcon(animated: true)
        }
    }
    
    @objc func quitApp() {
        NSApp.terminate(nil)
    }
    
    @objc func openPreferences() {
        PreferencesWindowController.shared.showWindow(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @objc private func updateMenuItems() {
        menu.item(at: 0)?.title = L10n.menuFadeTitle
    }
    
    private func updateIcon(animated: Bool) {
        guard let button = statusItem.button else { return }
        let imageName = screenFader.isFaded ? "moon.fill" : "sun.max.fill"
        
        let newImage = NSImage(
            systemSymbolName: imageName,
            accessibilityDescription: "Fade Status"
        )?.withSymbolConfiguration(.init(pointSize: 14, weight: .regular))
        
        if animated {
            button.animator().image = newImage
        } else {
            button.image = newImage
        }
    }
} 