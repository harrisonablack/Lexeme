import Foundation

struct PlaceholderDefinition: Identifiable, Equatable {
    let id: String
    let word: String
    let tags: [String]
    let definition: String
    let source: String
    let rootWord: String?

    var shortDefinition: String {
        String(definition.prefix(96)) + (definition.count > 96 ? "..." : "")
    }

    init(
        word: String,
        tags: [String],
        definition: String,
        source: String,
        rootWord: String? = nil
    ) {
        self.id = Self.normalizedKey(word)
        self.word = word
        self.tags = tags
        self.definition = definition
        self.source = source
        self.rootWord = rootWord
    }

    static func normalizedKey(_ value: String) -> String {
        value
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .trimmingCharacters(in: .punctuationCharacters)
            .lowercased()
    }

    static let samples = [
        PlaceholderDefinition(
            word: "lexeme",
            tags: ["Linguistics"],
            definition: "A fundamental unit of meaning in a language, considered independently from the inflected forms it may take.",
            source: "dictionaryapi.dev"
        ),
        PlaceholderDefinition(
            word: "orthodoxy",
            tags: ["Philosophy", "Religion"],
            definition: "The quality or state of conforming to an accepted doctrine, especially in belief or practice.",
            source: "Oxford Dictionary",
            rootWord: "orthodox"
        ),
        PlaceholderDefinition(
            word: "orthodox",
            tags: ["Philosophy", "Religion"],
            definition: "Conforming to what is generally or traditionally accepted as right or true; established and approved.",
            source: "Oxford Dictionary"
        ),
        PlaceholderDefinition(
            word: "aporia",
            tags: ["Philosophy", "Rhetoric"],
            definition: "An irresolvable internal contradiction or logical disjunction in a text, argument, or theory.",
            source: "Merriam-Webster"
        ),
        PlaceholderDefinition(
            word: "absurd",
            tags: ["Philosophy", "Literature"],
            definition: "A condition in which human beings search for meaning in a world that offers no final, rational answer.",
            source: "dictionaryapi.dev"
        ),
        PlaceholderDefinition(
            word: "nihilism",
            tags: ["Philosophy"],
            definition: "The doctrine or attitude that values, meaning, and truth lack objective foundation.",
            source: "Oxford Dictionary"
        ),
        PlaceholderDefinition(
            word: "dialectic",
            tags: ["Philosophy"],
            definition: "A method of reasoning that examines opposing ideas to expose tensions and move toward clearer understanding.",
            source: "Merriam-Webster"
        ),
        PlaceholderDefinition(
            word: "entropy",
            tags: ["Physics"],
            definition: "A measure of disorder, uncertainty, or unavailable energy within a system.",
            source: "dictionaryapi.dev"
        ),
        PlaceholderDefinition(
            word: "epistemology",
            tags: ["Philosophy"],
            definition: "The branch of philosophy concerned with knowledge, justification, belief, and the limits of understanding.",
            source: "Oxford Dictionary"
        ),
        PlaceholderDefinition(
            word: "ontology",
            tags: ["Philosophy"],
            definition: "The study of being, existence, and the categories by which reality is understood.",
            source: "Merriam-Webster"
        )
    ]
}
