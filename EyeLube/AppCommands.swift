import SwiftUI

struct AppCommands: Commands {
    @CommandsBuilder
    var body: some Commands {
        CommandGroup(replacing: .appInfo) {
            Button("About EyeLube") {
                NSApplication.shared.orderFrontStandardAboutPanel()
            }
        }
        CommandGroup(replacing: .newItem) { /* Disable new window menu */ }
    }
} 