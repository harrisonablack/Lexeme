import SwiftData
import Foundation

@Model
final class Definition {
    var word: String
    var definition: String
    var source: DefinitionSource
    
    init(word: String, definition: String, url: URL, source: DefinitionSource) {
        self.word = word
        self.definition = definition
        self.source = source
    }
    
    init(word: String, definition: String) {
        self.word = word;
        self.definition = definition;
    }
}

enum DefinitionSource {
    case oxford(URL)
    case merriamWebster(URL)
    case wiktionary(URL)
}
