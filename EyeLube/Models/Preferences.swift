import SwiftUI
import Combine

final class Preferences: ObservableObject {
    static let shared = Preferences()
    
    // SwiftUI-compatible property
    @Published var fadeDuration: Double = 3.0 {
        didSet {
            fadeDuration = min(max(fadeDuration, 0.5), 10.0)
        }
    }
    
    // Objective-C compatible property
    @objc dynamic var objcFadeDuration: Double {
        get { fadeDuration }
        set { fadeDuration = newValue }
    }
} 