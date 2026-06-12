import SwiftUI

struct NoDefinitionCard: View {
    let word: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("No definition found")
                .font(.system(size: 24, weight: .semibold, design: .serif))

            Text("No definition found for: \"\(word)\"")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: .black.opacity(0.12), radius: 18, y: 8)
    }
}
