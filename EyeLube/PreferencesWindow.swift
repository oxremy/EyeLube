import SwiftUI

struct PreferencesView: View {
    @ObservedObject var prefs = PreferencesStorage.shared
    @State private var recordingShortcut = false
    
    // Convert NSColor to Color for SwiftUI
    private var colorBinding: Binding<Color> {
        Binding(
            get: { Color(prefs.fadeColor) },
            set: { prefs.fadeColor = NSColor($0) }
        )
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Fade Settings
            GroupBox(label: Text("Fade Settings").font(.headline)) {
                VStack(alignment: .leading, spacing: 12) {
                    LabeledSlider(
                        label: "Duration:",
                        value: $prefs.fadeDuration,
                        range: 0.5...5.0,
                        format: "%.1f s"
                    )
                    
                    Divider()
                    
                    LabeledSlider(
                        label: "Max Opacity:",
                        value: Binding(
                            get: { Double(self.prefs.maxOpacity) },
                            set: { self.prefs.maxOpacity = CGFloat($0) }
                        ),
                        range: 0.1...1.0,
                        format: "%.0f%%"
                    )
                }
                .padding(.vertical, 8)
            }
            
            // Color Settings
            GroupBox(label: Text("Appearance").font(.headline)) {
                VStack(spacing: 12) {
                    HStack {
                        Text("Primary Color")
                            .frame(width: 100, alignment: .leading)
                        ColorPicker("", selection: colorBinding)
                            .labelsHidden()
                        
                        Spacer()
                        
                        Button("Reset") {
                            prefs.fadeColor = .black
                        }
                    }
                    
                    HStack {
                        Text("Opacity Control")
                            .frame(width: 100, alignment: .leading)
                        Slider(value: Binding(
                            get: { Double(self.prefs.maxOpacity) },
                            set: { self.prefs.maxOpacity = CGFloat($0) }
                        ), in: 0.1...1.0)
                        Text("\(Int(prefs.maxOpacity * 100))%")
                            .frame(width: 40)
                    }
                }
                .padding(.vertical, 8)
            }
            
            // Shortcut Configuration
            GroupBox(label: Text("Controls").font(.headline)) {
                VStack(alignment: .leading, spacing: 12) {
                    Toggle("Show Dock Icon", isOn: .constant(false))
                        .disabled(true)
                }
                .padding(.vertical, 8)
            }
        }
        .padding()
        .frame(width: 420, height: 400)
    }
}

private struct LabeledSlider: View {
    let label: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let format: String
    
    var body: some View {
        HStack {
            Text(label)
                .frame(width: 100, alignment: .leading)
            Slider(value: $value, in: range)
            Text(String(format: format, value))
                .frame(width: 60, alignment: .trailing)
        }
    }
}

struct PreferencesWindow: View {
    @EnvironmentObject var preferences: PreferencesStorage
    
    var body: some View {
        Form {
            Toggle("Launch at Login", isOn: $preferences.launchAtLogin)
            // Add other preferences controls
        }
        .padding()
        .frame(width: 400, height: 200)
    }
} 