import Foundation

struct PlaceholderDefinition: Identifiable, Equatable {
    let id: String
    let word: String
    let tags: [String]
    let partOfSpeech: String?
    let ipa: String?
    let phonetic: String?
    let definition: String
    let etymology: String?
    let source: String
    let rootWord: String?

    var shortDefinition: String {
        String(definition.prefix(96)) + (definition.count > 96 ? "..." : "")
    }

    init(
        word: String,
        tags: [String],
        partOfSpeech: String? = nil,
        ipa: String? = nil,
        phonetic: String? = nil,
        definition: String,
        etymology: String? = nil,
        source: String,
        rootWord: String? = nil
    ) {
        self.id = Self.normalizedKey(word)
        self.word = word
        self.tags = tags
        self.partOfSpeech = partOfSpeech
        self.ipa = ipa
        self.phonetic = phonetic
        self.definition = definition
        self.etymology = etymology
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
            partOfSpeech: "noun",
            ipa: "/ˈlɛksiːm/",
            phonetic: "LEK-seem",
            definition: "A fundamental unit of meaning in a language, considered independently from the inflected forms it may take.",
            etymology: "From French lexème, formed on Greek lexis, meaning word or speech.",
            source: "dictionaryapi.dev"
        ),
        PlaceholderDefinition(
            word: "orthodoxy",
            tags: ["Philosophy", "Religion"],
            partOfSpeech: "noun",
            ipa: "/ˈɔːrθədɒksi/",
            phonetic: "OR-thuh-dok-see",
            definition: "The quality or state of conforming to an accepted doctrine, especially in belief or practice.",
            etymology: "From Greek orthodoxia, meaning right opinion or correct belief.",
            source: "Oxford Dictionary",
            rootWord: "orthodox"
        ),
        PlaceholderDefinition(
            word: "orthodox",
            tags: ["Philosophy", "Religion"],
            partOfSpeech: "adjective",
            ipa: "/ˈɔːrθədɒks/",
            phonetic: "OR-thuh-doks",
            definition: "Conforming to what is generally or traditionally accepted as right or true; established and approved.",
            etymology: "From Greek orthodoxos, from orthos, right, and doxa, opinion.",
            source: "Oxford Dictionary"
        ),
        PlaceholderDefinition(
            word: "aporia",
            tags: ["Philosophy", "Rhetoric"],
            partOfSpeech: "noun",
            ipa: "/əˈpɔːriə/",
            phonetic: "uh-POR-ee-uh",
            definition: "An irresolvable internal contradiction or logical disjunction in a text, argument, or theory.",
            etymology: "From Greek aporia, meaning impasse, difficulty, or want of passage.",
            source: "Merriam-Webster"
        ),
        PlaceholderDefinition(
            word: "absurd",
            tags: ["Philosophy", "Literature"],
            partOfSpeech: "noun",
            ipa: "/əbˈsɜːrd/",
            phonetic: "ub-SURD",
            definition: "A condition in which human beings search for meaning in a world that offers no final, rational answer.",
            etymology: "From Latin absurdus, discordant or out of tune.",
            source: "dictionaryapi.dev"
        ),
        PlaceholderDefinition(
            word: "nihilism",
            tags: ["Philosophy"],
            partOfSpeech: "noun",
            ipa: "/ˈnaɪəlɪzəm/",
            phonetic: "NYE-uh-liz-um",
            definition: "The doctrine or attitude that values, meaning, and truth lack objective foundation.",
            etymology: "From Latin nihil, meaning nothing, with the doctrine-forming suffix -ism.",
            source: "Oxford Dictionary"
        ),
        PlaceholderDefinition(
            word: "dialectic",
            tags: ["Philosophy"],
            partOfSpeech: "noun",
            ipa: "/ˌdaɪəˈlɛktɪk/",
            phonetic: "DYE-uh-LEK-tik",
            definition: "A method of reasoning that examines opposing ideas to expose tensions and move toward clearer understanding.",
            etymology: "From Greek dialektike, the art of discourse or debate.",
            source: "Merriam-Webster"
        ),
        PlaceholderDefinition(
            word: "entropy",
            tags: ["Physics"],
            partOfSpeech: "noun",
            ipa: "/ˈɛntrəpi/",
            phonetic: "EN-truh-pee",
            definition: "A measure of disorder, uncertainty, or unavailable energy within a system.",
            etymology: "From Greek en, in, and trope, transformation or turning.",
            source: "dictionaryapi.dev"
        ),
        PlaceholderDefinition(
            word: "epistemology",
            tags: ["Philosophy"],
            partOfSpeech: "noun",
            ipa: "/ɪˌpɪstəˈmɒlədʒi/",
            phonetic: "ih-PIST-uh-MOL-uh-jee",
            definition: "The branch of philosophy concerned with knowledge, justification, belief, and the limits of understanding.",
            etymology: "From Greek episteme, knowledge, and -logia, study or discourse.",
            source: "Oxford Dictionary"
        ),
        PlaceholderDefinition(
            word: "ontology",
            tags: ["Philosophy"],
            partOfSpeech: "noun",
            ipa: "/ɒnˈtɒlədʒi/",
            phonetic: "on-TOL-uh-jee",
            definition: "The study of being, existence, and the categories by which reality is understood.",
            etymology: "From Greek ont-, being, and -logia, study or discourse.",
            source: "Merriam-Webster"
        )
    ]
}
