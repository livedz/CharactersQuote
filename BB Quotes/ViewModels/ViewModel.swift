//
//  ViewModel.swift
//  BB Quotes
//
//  Created by MOKSHA on 29/03/26.
//

import Foundation

@Observable
@MainActor
class ViewModel {
    
   enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed(error: Error)
   }
   private(set) var status: FetchStatus = .notStarted
   private let fetcher = FetchService()
   public var quote: Quote
   public var character: Char
   public var death: Death
    
    init() {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
     
        self.quote = AppURLS.loadJSON("samplequote") ?? Quote.mock
        self.character = AppURLS.loadJSON("samplecharacter") ?? Char.mock
        self.death = AppURLS.loadJSON("sampledeath") ?? Death.mock
    }
    
    func getData(for show: String) async {
        status = .fetching
        do {
            quote = try await fetcher.fetchQuotes(from: show)
            character = try await fetcher.fetchCharacter(quote.character)
            character.death = try await fetcher.fetchDeath(for: character.name)
            status = .success
        } catch {
            status = .failed(error: error)
        }
    }
}

extension Quote {
    static let mock = Quote(
        id: 1,
        quote: "I am the one who knocks!",
        character: "Walter White",
        production: "Breaking Bad",
        episode: 6
   )
}

extension Char {
    static let mock = Char(
        id: 1,
        name: "Walter White",
        birthday: "09-07-1958",
        occupations: ["Teacher", "Meth Kingpin"],
        images: ["https://example.com/walter.jpg"],
        fullName: "Walter Hartwell White",
        aliases: ["Heisenberg"],
        status: "Deceased",
        appearance: CharAppearance(breakingBad: [1,2,3,4,5], betterCallSaul: [6], elCamino: [1]),
        portrayedBy: "Bryan Cranston",
        productions: ["Breaking Bad"],
        death: Death.mock
    )
}

extension Death {
    static let mock = Death(
        id: 1,
        character: "Walter White",
        image: "https://static.wikia.nocookie.net/breakingbad/images/9/9e/Walt%27s_Death.png/revision/latest?cb=20221121191611",
        cause: "Gunshot",
        details: "Final shootout at the lab",
        responsible: ["Jack's Gang"],
        connected: ["Jesse Pinkman", "Jack Welker"],
        lastWords: "...",
        season: 5,
        episode: 16,
        production: "Breaking Bad"
    )
}
