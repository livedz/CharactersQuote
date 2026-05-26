//
//  Episode.swift
//  BB Quotes
//
//  Created by MOKSHA on 20/05/26.
//
import Foundation

struct Episode: Decodable, Identifiable {
    let id: Int
    let title: String
    let production: String
    let episode: Int
    let image: String?
    let synopsis: String?
    let writtenBy: String?
    let directedBy: String?
    let airDate: String?
    let characters: [String]?
    
    var seasonepisode: String {
        return ("Season \(episode / 100) Episode \(episode % 100)")
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "episode_id"
        case title
        case production
        case episode
        case image
        case airDate = "air_date"
        case writtenBy = "written_by"
        case synopsis
        case characters
        case directedBy = "directed_by"
    }
}
