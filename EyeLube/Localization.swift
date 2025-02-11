import Foundation
import SwiftUI  // Add SwiftUI import for UI components

struct L10n {
    private static var bundle: Bundle = .main
    
    static func configure(locale: Locale = .current) {
        guard let languageCode = locale.language.languageCode?.identifier,
              let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            bundle = .main
            return
        }
        bundle = Bundle(path: path) ?? .main
    }
    
    static func string(_ key: String, _ args: CVarArg...) -> String {
        let format = bundle.localizedString(forKey: key, value: nil, table: nil)
        return String(format: format, arguments: args)
    }
    
    // MARK: - Localized Strings
    static let menuFadeTitle = string("menu.fade.title")
    static let menuPreferences = string("menu.preferences")
    static let menuQuit = string("menu.quit")
    static let prefsWindowTitle = string("prefs.window.title")
}

// SwiftUI Integration
extension LocalizedStringKey {
    init(l10nKey: String) {
        self.init(L10n.string(l10nKey))
    }
}

extension Text {
    init(l10nKey: String) {
        self.init(L10n.string(l10nKey))
    }
}

// Add localized strings and language switching 

// Implement language switching and string externalization 

// New file to implement internationalization
// Will handle string localization using NSLocalizedString
// Needs integration points in menu items and preferences UI 