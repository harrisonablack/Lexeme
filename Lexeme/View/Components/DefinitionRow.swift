import SwiftUI

struct DefinitionRow: View {
    let word: String
    let definition: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(word)
                .font(.system(size: 18, weight: .semibold, design: .serif))
                .foregroundStyle(.primary)

            Text(definition)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .padding(.vertical, 4)
    }
}
