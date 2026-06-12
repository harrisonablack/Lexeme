import Foundation

struct DictionarySourceSetting: Identifiable {
    let id: String
    let name: String
    let detail: String
    let requiresKey: Bool
    var isEnabled: Bool
    var apiKey: String
    var keyWarning: String?

    static let defaults = [
        DictionarySourceSetting(
            id: "dictionaryapi-dev",
            name: "dictionaryapi.dev",
            detail: "Free default source",
            requiresKey: false,
            isEnabled: true,
            apiKey: "",
            keyWarning: nil
        ),
        DictionarySourceSetting(
            id: "merriam-webster",
            name: "Merriam-Webster",
            detail: "User-provided API key",
            requiresKey: true,
            isEnabled: false,
            apiKey: "",
            keyWarning: nil
        ),
        DictionarySourceSetting(
            id: "oxford",
            name: "Oxford",
            detail: "User-provided API key",
            requiresKey: true,
            isEnabled: false,
            apiKey: "",
            keyWarning: nil
        )
    ]
}
