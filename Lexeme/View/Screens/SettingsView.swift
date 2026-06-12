import SwiftUI

struct SettingsView: View {
    @Binding var stackLimit: Int
    @Binding var cacheRetention: String

    @State private var sources = DictionarySourceSetting.defaults

    var body: some View {
        List {
            Section {
                ForEach($sources) { $source in
                    SourceSettingRow(source: $source)
                }
                .onMove { indices, newOffset in
                    sources.move(fromOffsets: indices, toOffset: newOffset)
                }
            } header: {
                Text("Sources")
            } footer: {
                Text("Sources are tried in order. Keyed sources stay disabled until an API key exists.")
            }

            Section {
                Picker("Retention", selection: $cacheRetention) {
                    ForEach(["7 days", "30 days", "90 days", "Forever"], id: \.self) { value in
                        Text(value).tag(value)
                    }
                }

                Picker("Visible stack", selection: $stackLimit) {
                    ForEach([5, 10, 20, 50], id: \.self) { value in
                        Text("\(value)").tag(value)
                    }
                }
            } header: {
                Text("Cache")
            }

            Section {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.")
                    .foregroundStyle(.secondary)
            } header: {
                Text("Privacy")
            }

            Section {
                LabeledContent("Version", value: "1.0")
            }
        }
        .navigationTitle("Settings")
        .toolbar {
            EditButton()
        }
    }
}
