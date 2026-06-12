import SwiftUI

struct StarredListView: View {
    let definitions: [PlaceholderDefinition]
    let onSelect: (PlaceholderDefinition) -> Void

    var body: some View {
        List {
            if definitions.isEmpty {
                ContentUnavailableView(
                    "No Starred Words",
                    systemImage: "star",
                    description: Text("Star a definition to keep it here.")
                )
            } else {
                ForEach(definitions) { definition in
                    Button {
                        onSelect(definition)
                    } label: {
                        DefinitionRow(word: definition.word, definition: definition.shortDefinition)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .navigationTitle("Starred")
    }
}
