import SwiftUI

struct SearchCommandField: View {
    @Binding var text: String

    let isFocused: FocusState<Bool>.Binding
    let onSubmit: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 17, weight: .medium))
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(.secondary)

            TextField("Define a lexeme", text: $text)
                .focused(isFocused)
                .submitLabel(.search)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .font(.title3.weight(.medium))
                .onSubmit(onSubmit)
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(.ultraThinMaterial, in: Capsule())
        .glassEffect(.regular, in: Capsule())
    }
}
