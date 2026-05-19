//
//  FetchService.swift
//  BB Quotes
//
//  Created by MOKSHA on 18/03/26.
//

import Foundation

struct FetchService {
 
       private enum FetchError: Error {
            case badResponse
        }
        
        func fetchQuotes(from show: String) async throws -> Quote {
            var fetchURL = AppURLConstant.baseURL
                .appendingPathComponent(AppURLConstant.quoteURL)
            
            fetchURL.append(queryItems: [
                URLQueryItem(name: AppURLConstant.productionURL, value: show)
            ])
            
            let (data, response) = try await URLSession.shared.data(from: fetchURL)
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                throw FetchError.badResponse
            }
            
            let decoder = JSONDecoder()

            do {
                let single = try decoder.decode(Quote.self, from: data)
                return single
            } catch let err as DecodingError {
                switch err {
                case .keyNotFound(let key, let context):
                    print("[fetchQuotes] Missing key:", key.stringValue, "|", context.debugDescription, "| path:", context.codingPath)
                case .typeMismatch(let type, let context):
                    print("[fetchQuotes] Type mismatch:", type, "|", context.debugDescription, "| path:", context.codingPath)
                case .valueNotFound(let type, let context):
                    print("[fetchQuotes] Value not found:", type, "|", context.debugDescription, "| path:", context.codingPath)
                case .dataCorrupted(let context):
                    print("[fetchQuotes] Data corrupted:", context.debugDescription, "| path:", context.codingPath)
                @unknown default:
                    print("[fetchQuotes] Unknown decoding error:", err)
                }
                throw err
            } catch {
                let quotes = try decoder.decode([Quote].self, from: data)
                guard let first = quotes.first else { throw FetchError.badResponse }
                return first
            }
        }
        
        func fetchCharacter(_ name: String) async throws -> Char {
            
            var fetchURL = AppURLConstant.baseURL
                .appendingPathComponent(AppURLConstant.characters)
            fetchURL.append(queryItems: [
                URLQueryItem(name: AppURLConstant.name, value: name)
            ])
            
            let (data, response) = try await URLSession.shared.data(from: fetchURL)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                throw FetchError.badResponse
            }
            
            let decoder = JSONDecoder()
            
            let characters: [Char]

            do {
                characters = try decoder.decode([Char].self, from: data)
            } catch let err as DecodingError {
                switch err {
                case .keyNotFound(let key, let context):
                    print("[fetchCharacter] Missing key:", key.stringValue, "|", context.debugDescription, "| path:", context.codingPath)
                case .typeMismatch(let type, let context):
                    print("[fetchCharacter] Type mismatch:", type, "|", context.debugDescription, "| path:", context.codingPath)
                case .valueNotFound(let type, let context):
                    print("[fetchCharacter] Value not found:", type, "|", context.debugDescription, "| path:", context.codingPath)
                case .dataCorrupted(let context):
                    print("[fetchCharacter] Data corrupted:", context.debugDescription, "| path:", context.codingPath)
                @unknown default:
                    print("[fetchCharacter] Unknown decoding error:", err)
                }
                throw err
            } catch {
                print("[fetchCharacter] Other decode error:", error)
                throw error
            }

            guard let first = characters.first else {
                throw FetchError.badResponse
            }
            return first
        }
        
        func fetchDeath(for character: String) async throws -> Death? {
            let fetchURL = AppURLConstant.baseURL
                .appendingPathComponent(AppURLConstant.deaths)
            
            let (data, response) = try await URLSession.shared.data(from: fetchURL)
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                throw FetchError.badResponse
            }
            
            let decoder = JSONDecoder()
            let deaths: [Death]

            do {
                deaths = try decoder.decode([Death].self, from: data)
            } catch let err as DecodingError {
                switch err {
                case .keyNotFound(let key, let context):
                    print("[fetchDeath] Missing key:", key.stringValue, "|", context.debugDescription, "| path:", context.codingPath)
                case .typeMismatch(let type, let context):
                    print("[fetchDeath] Type mismatch:", type, "|", context.debugDescription, "| path:", context.codingPath)
                case .valueNotFound(let type, let context):
                    print("[fetchDeath] Value not found:", type, "|", context.debugDescription, "| path:", context.codingPath)
                case .dataCorrupted(let context):
                    print("[fetchDeath] Data corrupted:", context.debugDescription, "| path:", context.codingPath)
                @unknown default:
                    print("[fetchDeath] Unknown decoding error:", err)
                }
                throw err
            } catch {
                print("[fetchDeath] Other decode error:", error)
                throw error
            }
            
            return deaths.first { $0.character == character }
        }
}
