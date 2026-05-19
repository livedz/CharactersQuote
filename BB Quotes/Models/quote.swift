//
//  quote.swift
//  BB Quotes
//
//  Created by MOKSHA on 11/03/26.
//
struct Quote: Decodable, Identifiable {
    let id: Int
    let quote: String
    let character: String
    let production: String
    let episode: Int

    enum CodingKeys: String, CodingKey {
        case id = "quote_id"
        case quote
        case character
        case production
        case episode
    }
}
