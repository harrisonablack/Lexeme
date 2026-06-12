import SwiftData
import Foundation

@Model
final class Definition {
    var word: String
    var definition: String
    var source: DefinitionSource?
    var sourceURL: URL?
    
    init(word: String, definition: String, url: URL, source: DefinitionSource) {
        self.word = word
        self.definition = definition
        self.source = source
        self.sourceURL = url
    }
    
    init(word: String, definition: String) {
        self.word = word
        self.definition = definition
    }
}

enum DefinitionSource: String, Codable {
    case oxford
    case merriamWebster
    case wiktionary
}
