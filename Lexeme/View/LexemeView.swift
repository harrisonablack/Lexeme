import SwiftUI
import UIKit

struct LexemeView: View {
    @FocusState private var isSearchFocused: Bool

    @State private var searchText = ""
    @State private var displayedCards: [LookupCard] = []
    @State private var starredDefinitions: [String: PlaceholderDefinition] = [:]
    @State private var selectedTab = MainTab.home
    @State private var stackLimit = 20
    @State private var cacheRetention = "30 days"

    private let definitions = PlaceholderDefinition.samples

    private var definitionIndex: [String: PlaceholderDefinition] {
        Dictionary(uniqueKeysWithValues: definitions.map { ($0.id, $0) })
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()

                mainContent
            }
            .tabItem {
                Label("Home", systemImage: "house")
                    .labelStyle(.iconOnly)
            }
            .tag(MainTab.home)

            NavigationStack {
                StarredListView(
                    definitions: starredDefinitions.values.sorted { $0.word < $1.word },
                    onSelect: loadStarredDefinition
                )
            }
            .tabItem {
                Label("Saved", systemImage: "star")
                    .labelStyle(.iconOnly)
            }
            .tag(MainTab.saved)

            NavigationStack {
                SettingsView(stackLimit: $stackLimit, cacheRetention: $cacheRetention)
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
                    .labelStyle(.iconOnly)
            }
            .tag(MainTab.settings)
        }
        .tint(Color(red: 0.42, green: 0.51, blue: 0.62))
        .preferredColorScheme(.dark)
        .onAppear {
            isSearchFocused = true
        }
        .onChange(of: selectedTab) { _, _ in
            dismissKeyboard()
        }
    }

    private var mainContent: some View {
        VStack(spacing: 14) {
            SearchCommandField(
                text: $searchText,
                isFocused: $isSearchFocused,
                onSubmit: submitSearch
            )
            .padding(.horizontal, 16)

            if displayedCards.isEmpty {
                emptyGuidance
                    .transition(.opacity)
            } else {
                resultStack
                    .transition(.opacity)
            }
        }
        .padding(.top, 10)
        .animation(.smooth(duration: 0.24), value: displayedCards.isEmpty)
    }

    private var emptyGuidance: some View {
        Color.clear
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                dismissKeyboard()
            }
    }

    private var resultStack: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                ForEach(displayedCards) { card in
                    switch card {
                    case .definition(let definition):
                        DefinitionCard(
                            definition: definition,
                            isStarred: starredDefinitions[definition.id] != nil,
                            onToggleStar: { toggleStar(definition) },
                            onDefineRoot: { root in replace(definition, withRoot: root) }
                        )
                        .transition(.opacity)
                    case .notFound(let word):
                        NoDefinitionCard(word: word)
                            .transition(.opacity)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 28)
        }
        .scrollDismissesKeyboard(.interactively)
        .simultaneousGesture(
            TapGesture().onEnded {
                dismissKeyboard()
            }
        )
    }

    private func submitSearch() {
        let normalized = PlaceholderDefinition.normalizedKey(searchText)
        guard !normalized.isEmpty else { return }

        searchText = ""

        if let definition = definitionIndex[normalized] {
            show(.definition(definition))
            impact(.soft)
        } else {
            show(.notFound(normalized))
        }
    }

    private func show(_ card: LookupCard) {
        withAnimation(.smooth(duration: 0.24)) {
            displayedCards.removeAll { $0.lookupKey == card.lookupKey }
            displayedCards.insert(card, at: 0)

            if displayedCards.count > stackLimit {
                displayedCards = Array(displayedCards.prefix(stackLimit))
            }
        }
    }

    private func toggleStar(_ definition: PlaceholderDefinition) {
        if starredDefinitions[definition.id] == nil {
            starredDefinitions[definition.id] = definition
        } else {
            starredDefinitions.removeValue(forKey: definition.id)
        }

        impact(.light)
    }

    private func replace(_ definition: PlaceholderDefinition, withRoot root: String) {
        guard let rootDefinition = definitionIndex[PlaceholderDefinition.normalizedKey(root)] else { return }
        let replacement = LookupCard.definition(rootDefinition)

        displayedCards.removeAll { $0.lookupKey == rootDefinition.id }

        if let index = displayedCards.firstIndex(where: { $0.lookupKey == definition.id }) {
            displayedCards[index] = replacement
        } else {
            show(replacement)
        }

        impact(.soft)
    }

    private func loadStarredDefinition(_ definition: PlaceholderDefinition) {
        selectedTab = .home
        show(.definition(definition))
    }

    private func dismissKeyboard() {
        isSearchFocused = false
    }

    private func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
