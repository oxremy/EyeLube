import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Configure activation policy
        NSApp.setActivationPolicy(.accessory)
        
        setupMenu()
    }
    
    private func setupMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(
            title: "Fade Screen",
            action: #selector(triggerFade),
            keyEquivalent: "F"
        ).withTooltip("Toggle screen dimming"))
        
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(
            title: "Quit EyeLube",
            action: #selector(NSApp.terminate(_:)),
            keyEquivalent: "q"
        ))
        
        statusItem.menu = menu
    }
    
    @objc private func triggerFade() {
        // Removed sound playback and ShortcutManager reference
        // Add fade logic here or call to ScreenFader
    }
    
    func applicationDidResignActive(_ notification: Notification) {
        // Temporarily removed until ScreenFader is updated
        // ScreenFader.shared.cleanupResources()
    }
    
    func dockMenu(_ sender: NSApplication?) -> NSMenu? {
        let dockMenu = NSMenu()
        dockMenu.addItem(
            withTitle: "Toggle Fade",
            action: #selector(triggerFade),
            keyEquivalent: "D"
        )
        return dockMenu
    }
}

// Helper extension for tooltip
extension NSMenuItem {
    func withTooltip(_ tooltip: String) -> Self {
        self.toolTip = tooltip
        return self
    }
} 