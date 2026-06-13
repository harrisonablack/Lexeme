import SwiftUI

struct LexemeView: View {
    @State private var starredDefinitions: [String: PlaceholderDefinition] = [:]
    @State private var selectedTab = MainTab.home
    @State private var stackLimit = 20
    @State private var cacheRetention = "30 days"
    @State private var definitionToShow: PlaceholderDefinition?

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(
                starredDefinitions: $starredDefinitions,
                definitionToShow: $definitionToShow,
                stackLimit: stackLimit,
                isSelected: selectedTab == .home
            )
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
        .preferredColorScheme(.dark)
    }

    private func loadStarredDefinition(_ definition: PlaceholderDefinition) {
        definitionToShow = definition
        selectedTab = .home
    }
}

#Preview {
    LexemeView()
}
