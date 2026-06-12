import Foundation

enum LookupCard: Identifiable, Equatable {
    case definition(PlaceholderDefinition)
    case notFound(String)

    var id: String {
        switch self {
        case .definition(let definition): "definition-\(definition.id)"
        case .notFound(let word): "missing-\(word)"
        }
    }

    var lookupKey: String {
        switch self {
        case .definition(let definition): definition.id
        case .notFound(let word): "missing-\(word)"
        }
    }
}
