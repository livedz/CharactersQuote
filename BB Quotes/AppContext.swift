//
// AppContext.swift
//  BB Quotes
//
//  Created by MOKSHA on 27/03/26.
//

import Foundation

public enum AppURLConstant {
    public static let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    public static let quoteURL = "quotes/random"
    public static let productionURL = "production"
    public static let characters = "characters"
    public static let name = "name"
    public static let deaths = "deaths"
}

public enum AppURLS {
    public static func getQuotesURL() -> URL? {
        let quoteURL = AppURLConstant.baseURL.appending(path: AppURLConstant.quoteURL)
        return quoteURL
    }
    
    public static func loadJSON<T: Decodable>(_ filename: String) -> T? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        // Try single object first
        if let object = try? decoder.decode(T.self, from: data) {
            return object
        }
        // Then try array
        if let array = try? decoder.decode([T].self, from: data) {
            return array.first
        }
        return nil
    }
}

struct TabDetails: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}

