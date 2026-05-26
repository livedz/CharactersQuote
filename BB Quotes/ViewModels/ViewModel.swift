//
//  ViewModel.swift
//  BB Quotes
//
//  Created by MOKSHA on 29/03/26.
//

import Foundation

@available(iOS 17.0, *)
@Observable
@MainActor
class ViewModel {
    
   enum FetchStatus {
        case notStarted
        case fetching
        case successQuote
        case successEpisode
        case failed(error: Error)
   }
   private(set) var status: FetchStatus = .notStarted
   private let fetcher = FetchService()
   public var quote: Quote
   public var character: Char
   public var death: Death
    public var episodeDetails: Episode
    
    init() {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
     
        self.quote = AppURLS.loadJSON("samplequote") ?? Quote.mock
        self.character = AppURLS.loadJSON("samplecharacter") ?? Char.mock
        self.death = AppURLS.loadJSON("sampledeath") ?? Death.mock
        self.episodeDetails = AppURLS.loadJSON("sampleepisode") ?? Episode.mock
    }
    
    func getQuoterData(for show: String) async {
        status = .fetching
        do {
            quote = try await fetcher.fetchQuotes(from: show)
            character = try await fetcher.fetchCharacter(quote.character)
            character.death = try await fetcher.fetchDeath(for: character.name)
            if let episodeData = try await fetcher.fetchEpisode(for: show) {
                episodeDetails = episodeData
            }
            status = .successQuote
        } catch {
            status = .failed(error: error)
        }
    }
    
    func getEpisodeData(for show: String) async {
        status = .fetching
        do {
            if let episodeData = try await fetcher.fetchEpisode(for: show) {
                episodeDetails = episodeData
            }
            status = .successEpisode
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

extension Episode {
    
    static let mock = Episode(
        id: 1,
        title: "Pilot",
        production: "Breaking Bad",
        episode: 101,
        image: "https://static.wikia.nocookie.net/breakingbad/images/b/b1/BB_101_S.jpg/revision/latest?cb=20170418193804",
        synopsis: "Desperate to secure his family's financial future and finally free from the fear that had always inhibited him, Walt teams up with a former student to turn a used RV into a mobile drug lab.",
        writtenBy: "Vince Gilligan",
        directedBy: "Vince Gilligan",
        airDate: "01-20-2008",
        characters: [
            "Walter White",
            "Jesse Pinkman",
            "Skyler White",
            "Walter Jr.",
            "Ben",
            "Chad"]
    )
}
