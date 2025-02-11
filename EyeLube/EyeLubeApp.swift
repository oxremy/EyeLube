//
//  EyeLubeApp.swift
//  EyeLube
//
//  Created by oxremy on 2/10/25.
//

import SwiftUI

@main
struct EyeLubeApp: App {
    @StateObject private var statusBar = StatusBarController()
    private let preferencesStorage = PreferencesStorage.shared
    
    init() {
        // Version compatibility checks
        if #available(macOS 13.0, *) {
            SystemPreferencesManager.shared.syncWithSystemAppearance()
        }
        
        // Localization setup
        L10n.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            CompatibilityView()
                .frame(width: 0, height: 0)
                .hidden()
                .environmentObject(preferencesStorage)
                .onAppear {
                    SystemPreferencesManager.shared.setLaunchAtLogin(
                        enabled: preferencesStorage.launchAtLogin
                    )
                }
        }
        .commands { AppCommands() }
        
        Settings {
            PreferencesWindowView()
        }
    }
}

struct CompatibilityView: View {
    @StateObject private var preferencesStorage = PreferencesStorage.shared
    
    var body: some View {
        Text("Compatibility Layer").hidden()
    }
}

struct PreferencesWindowView: View {
    @EnvironmentObject var preferences: PreferencesStorage
    var body: some View {
        PreferencesWindow()
    }
}
