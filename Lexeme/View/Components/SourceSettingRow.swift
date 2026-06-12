import SwiftUI

struct SourceSettingRow: View {
    @Binding var source: DictionarySourceSetting

    private var hasRequiredKey: Bool {
        !source.requiresKey || !source.apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(source.name)
                        .font(.body.weight(.medium))

                    Text(source.detail)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Toggle("Enabled", isOn: $source.isEnabled)
                    .labelsHidden()
                    .disabled(!hasRequiredKey)
            }

            if source.requiresKey {
                SecureField("API key", text: $source.apiKey)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

                HStack(spacing: 10) {
                    Button("Test API Key") {
                        source.keyWarning = hasRequiredKey ? nil : "API key required"
                    }
                    .buttonStyle(.borderless)

                    if let keyWarning = source.keyWarning {
                        Text(keyWarning)
                            .font(.caption)
                            .foregroundStyle(.orange)
                    }
                }
            }
        }
        .padding(.vertical, 4)
        .onChange(of: source.apiKey) { _, newValue in
            if newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                source.isEnabled = false
            }

            source.keyWarning = nil
        }
    }
}
