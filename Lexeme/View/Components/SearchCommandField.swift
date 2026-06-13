import SwiftUI
import UIKit

struct SearchCommandField: View {
    @Binding var text: String

    let isFocused: FocusState<Bool>.Binding
    let onSubmit: () -> Void

    private var ivory: Color {
        Color(red: 0.96, green: 0.94, blue: 0.88)
    }

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 17, weight: .medium))
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(ivory.opacity(0.58))

            TextField(
                "Define a lexeme",
                text: $text,
                prompt: Text("Define a lexeme").foregroundColor(ivory.opacity(0.42))
            )
                .focused(isFocused)
                .submitLabel(.search)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .font(.system(size: 18, weight: .medium, design: .serif))
                .foregroundStyle(ivory.opacity(0.92))
                .tint(ivory)
                .onSubmit(onSubmit)
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background {
            Capsule()
                .fill(Color(uiColor: .systemGroupedBackground))
        }
        .overlay {
            Capsule()
                .strokeBorder(ivory.opacity(0.18), lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.16), radius: 12, y: 7)
    }
}
