import AppKit

@available(macOS 11.0, *)
public class ScreenFader {
    static let shared = ScreenFader()
    public init() {}
    
    private var overlayWindow: NSWindow?
    internal private(set) var isFaded: Bool = false
    
    func toggleFade() {
        isFaded ? fadeOut() : fadeIn()
        isFaded.toggle()
    }
    
    private func fadeIn() {
        createOverlayWindow()
        NSAnimationContext.runAnimationGroup { context in
            context.duration = PreferencesStorage.shared.fadeDuration
            overlayWindow?.animator().alphaValue = PreferencesStorage.shared.maxOpacity
        }
    }
    
    private func fadeOut() {
        NSAnimationContext.runAnimationGroup { context in
            context.duration = PreferencesStorage.shared.fadeDuration
            overlayWindow?.animator().alphaValue = 0
        } completionHandler: {
            self.overlayWindow?.close()
            self.overlayWindow = nil
        }
    }
    
    private func createOverlayWindow() {
        let screenRect = NSScreen.screens.map { $0.frame }.reduce(CGRect.null, { $0.union($1) })
        
        overlayWindow = NSWindow(contentRect: screenRect,
                                styleMask: .borderless,
                                backing: .buffered,
                                defer: false)
        
        guard let overlayWindow = overlayWindow else { return }
        
        overlayWindow.isOpaque = false
        overlayWindow.backgroundColor = PreferencesStorage.shared.fadeColor
        overlayWindow.alphaValue = 0
        overlayWindow.level = .screenSaver
        overlayWindow.ignoresMouseEvents = true
        overlayWindow.collectionBehavior = [.stationary, .ignoresCycle]
        overlayWindow.makeKeyAndOrderFront(nil)
        
        // Observe screen configuration changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateWindowFrame),
            name: NSApplication.didChangeScreenParametersNotification,
            object: nil
        )
    }
    
    @objc private func updateWindowFrame() {
        let newFrame = NSScreen.screens.map { $0.frame }.reduce(CGRect.null, { $0.union($1) })
        overlayWindow?.setFrame(newFrame, display: true)
    }
    
    func cleanupResources() {
        // Implement cleanup logic here
    }
} 