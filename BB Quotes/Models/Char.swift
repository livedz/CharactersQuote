//
//  Char.swift
//  BB Quotes
//
//  Created by MOKSHA on 12/05/26.
//

import Foundation

struct Char: Decodable, Identifiable {
    let id: Int
    let name: String
    let birthday: String?
    let occupations: [String]?
    let images: [String]?
    let fullName: String?
    let aliases: [String]?
    let status: String?
    let appearance: CharAppearance?
    let portrayedBy: String?
    let productions: [String]?
    var death: Death?

    enum CodingKeys: String, CodingKey {
        case id = "character_id"
        case name
        case birthday
        case occupations
        case images
        case fullName = "full_name"
        case aliases
        case status
        case appearance
        case portrayedBy = "portrayed_by"
        case productions
        case death
    }
}

struct CharAppearance: Decodable {
    let breakingBad: [Int]?
    let betterCallSaul: [Int]?
    let elCamino: [Int]?

    enum CodingKeys: String, CodingKey {
        case breakingBad = "breaking_bad"
        case betterCallSaul = "better_call_saul"
        case elCamino = "el_camino"
    }
}

struct Death: Decodable, Identifiable {
    let id: Int
    let character: String
    let image: String?
    let cause: String?
    let details: String?
    let responsible: [String]?
    let connected: [String]?
    let lastWords: String?
    let season: Int?
    let episode: Int?
    let production: String?

    enum CodingKeys: String, CodingKey {
        case id = "death_id"
        case image
        case character
        case cause
        case details
        case responsible
        case connected
        case lastWords = "last_words"
        case season
        case episode
        case production
    }
}
