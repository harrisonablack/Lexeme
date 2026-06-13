import SwiftUI
import UIKit

struct DefinitionCard: View {
    let definition: PlaceholderDefinition
    let isStarred: Bool
    let onToggleStar: () -> Void
    let onDefineRoot: (String) -> Void

    private var visibleRootWord: String? {
        guard let rootWord = definition.rootWord else { return nil }
        return PlaceholderDefinition.normalizedKey(rootWord) == definition.id ? nil : rootWord
    }

    private var pronunciationLine: String? {
        let pieces = [definition.ipa, definition.phonetic].compactMap { value -> String? in
            guard let value, !value.isEmpty else { return nil }
            return value
        }

        return pieces.isEmpty ? nil : pieces.joined(separator: "  ·  ")
    }

    private var metadataPills: [String] {
        var pills: [String] = []

        if let partOfSpeech = definition.partOfSpeech, !partOfSpeech.isEmpty {
            pills.append(partOfSpeech)
        }

        pills.append(contentsOf: definition.tags)
        return pills
    }

    private var ivory: Color {
        Color(red: 0.96, green: 0.94, blue: 0.88)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(definition.word)
                        .font(.system(size: 46, weight: .semibold, design: .serif))
                        .kerning(-0.7)
                        .foregroundStyle(ivory.opacity(0.96))
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)

                    if let pronunciationLine {
                        Text(pronunciationLine)
                            .font(.system(size: 14, weight: .medium, design: .serif))
                            .tracking(0.3)
                            .foregroundStyle(ivory.opacity(0.64))
                    }
                }

                Spacer(minLength: 10)

                Button(action: onToggleStar) {
                    Image(systemName: isStarred ? "star.fill" : "star")
                        .font(.system(size: 18, weight: .semibold))
                        .symbolRenderingMode(.hierarchical)
                        .foregroundStyle(isStarred ? ivory.opacity(0.94) : ivory.opacity(0.58))
                        .frame(width: 38, height: 38)
                        .background(
                            Circle()
                                .fill(Color.black.opacity(isStarred ? 0.34 : 0.22))
                        )
                        .overlay {
                            Circle()
                                .strokeBorder(ivory.opacity(isStarred ? 0.22 : 0.11), lineWidth: 1)
                        }
                }
                .buttonStyle(.plain)
                .accessibilityLabel(isStarred ? "Unstar word" : "Star word")
            }

            if !metadataPills.isEmpty {
                HStack(spacing: 8) {
                    ForEach(metadataPills, id: \.self) { tag in
                        Text(tag.uppercased())
                            .font(.caption2.weight(.semibold))
                            .tracking(0.8)
                            .foregroundStyle(ivory.opacity(0.78))
                            .padding(.horizontal, 9)
                            .padding(.vertical, 5)
                            .background(
                                Capsule()
                                    .fill(Color.black.opacity(0.24))
                            )
                            .overlay {
                                Capsule()
                                    .strokeBorder(ivory.opacity(0.13), lineWidth: 1)
                            }
                    }
                }
            }

            HStack(alignment: .firstTextBaseline, spacing: 10) {
                Text("1")
                    .font(.system(size: 12, weight: .semibold, design: .serif))
                    .foregroundStyle(ivory.opacity(0.48))
                    .frame(width: 16, alignment: .leading)

                Text(definition.definition)
                    .font(.system(size: 17, weight: .regular, design: .serif))
                    .lineSpacing(4)
                    .foregroundStyle(ivory.opacity(0.9))
            }

            if let etymology = definition.etymology, !etymology.isEmpty {
                HStack(alignment: .firstTextBaseline, spacing: 10) {
                    Text("ETY.")
                        .font(.system(size: 10, weight: .bold, design: .serif))
                        .tracking(1)
                        .foregroundStyle(ivory.opacity(0.48))
                        .frame(width: 28, alignment: .leading)

                    Text(etymology)
                        .font(.system(size: 13, weight: .regular, design: .serif))
                        .lineSpacing(2)
                        .foregroundStyle(ivory.opacity(0.66))
                        .lineLimit(2)
                }
            }

            Rectangle()
                .fill(ivory.opacity(0.08))
                .frame(height: 1)
                .padding(.top, 1)

            HStack(spacing: 10) {
                Text("Source: \(definition.source)")
                    .font(.system(size: 11, weight: .medium, design: .monospaced))
                    .foregroundStyle(ivory.opacity(0.48))
                    .lineLimit(1)
                    .minimumScaleFactor(0.82)

                Spacer(minLength: 8)

                if let visibleRootWord {
                    Text("root \(visibleRootWord)")
                        .font(.system(size: 11, weight: .medium, design: .monospaced))
                        .foregroundStyle(ivory.opacity(0.48))
                        .lineLimit(1)

                    Button {
                        onDefineRoot(visibleRootWord)
                    } label: {
                        Image(systemName: "arrow.up.left.circle")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(ivory.opacity(0.68))
                            .frame(width: 30, height: 30)
                            .contentShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Define root word \(visibleRootWord)")
                }
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(uiColor: .systemGroupedBackground))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(ivory.opacity(0.18), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.22), radius: 14, y: 8)
    }
}

#Preview("Definition Card") {
    ZStack {
        Color.black.ignoresSafeArea()

        DefinitionCard(
            definition: PlaceholderDefinition.samples[0],
            isStarred: false,
            onToggleStar: {},
            onDefineRoot: { _ in }
        )
        .padding()
    }
    .preferredColorScheme(.dark)
}
