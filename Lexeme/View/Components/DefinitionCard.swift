import SwiftUI

struct DefinitionCard: View {
    let definition: PlaceholderDefinition
    let isStarred: Bool
    let onToggleStar: () -> Void
    let onDefineRoot: (String) -> Void

    private var visibleRootWord: String? {
        guard let rootWord = definition.rootWord else { return nil }
        return PlaceholderDefinition.normalizedKey(rootWord) == definition.id ? nil : rootWord
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            HStack(alignment: .firstTextBaseline) {
                Text(definition.word)
                    .font(.system(size: 36, weight: .semibold, design: .serif))
                    .lineLimit(2)
                    .minimumScaleFactor(0.82)

                Spacer(minLength: 12)

                Button(action: onToggleStar) {
                    Image(systemName: isStarred ? "star.fill" : "star")
                        .font(.system(size: 19, weight: .medium))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(isStarred ? .primary : .secondary)
                        .frame(width: 34, height: 34)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(isStarred ? "Unstar word" : "Star word")
            }

            if !definition.tags.isEmpty {
                HStack(spacing: 8) {
                    ForEach(definition.tags, id: \.self) { tag in
                        Text(tag.uppercased())
                            .font(.caption2.weight(.semibold))
                            .tracking(0.7)
                            .foregroundStyle(Color(red: 0.42, green: 0.51, blue: 0.62))
                    }
                }
            }

            Text(definition.definition)
                .font(.body)
                .lineSpacing(2)
                .foregroundStyle(.primary)

            if let visibleRootWord {
                Button("Define \(visibleRootWord)") {
                    onDefineRoot(visibleRootWord)
                }
                .buttonStyle(.bordered)
                .controlSize(.small)
                .padding(.top, 2)
            }

            Text("Source: \(definition.source)")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .padding(.top, 2)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: .black.opacity(0.12), radius: 18, y: 8)
    }
}
