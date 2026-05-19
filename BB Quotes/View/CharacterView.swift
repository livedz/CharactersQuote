//
//  CharacterView.swift
//  BB Quotes
//
//  Created by MOKSHA on 22/04/26.
//
import SwiftUI

struct CharacterView: View {
    let character: Char
    let show: String
 
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                let backgroundImage = show == "Breaking Bad" ? "Image1" : "Image2"
                Image(backgroundImage)
                    .resizable()
                    .scaledToFit()
                    .mask(
                        LinearGradient(stops: [
                            .init(color: .black, location: 0.0),
                            .init(color: .black, location: 0.8),
                            .init(color: .clear, location: 1.0)
                        ], startPoint: .top, endPoint: .bottom)
                    )
                
                
                ScrollView {
                    if let charImages = character.images, let charImage = charImages.first {
                        AsyncImage(url: URL(string: charImage)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: max(geo.size.width / 1.2, 0), height: max(geo.size.height / 1.5, 0))
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.top, 105)
                        .shadow(color: .defaultYellow, radius: 2)
                    }
                    VStack(alignment: .leading) {
                      
                        if let portrayedBy = character.portrayedBy {
                            Text(character.name)
                                .font(.largeTitle)
                            Text("Portrayed By: \(portrayedBy)")
                                .font(.subheadline)
                            Divider()
                        }
                     
                        if let birthdate = character.birthday {
                            
                            Text("\(character.name) Character Info")
                                .font(.title2)
                            Text("Born: \(birthdate)")
                                .font(.title3)
                            Divider()
                        }
                        
                        if let occupations = character.occupations {
                            Text("Occupations:")
                                .font(.title3)
                            ForEach(occupations, id: \.self) {
                                occupation in
                                Text("◦ \(occupation)")
                                    .font(.subheadline)
                            }
                            Divider()
                        }
                        
                        
                        if let occupations = character.aliases {
                            Text("Nicknames: ")
                                .font(.title3)
                            ForEach(occupations, id: \.self) {
                                aliase in
                                Text("◦ \(aliase)")
                                    .font(.subheadline)
                            }
                            Divider()
                        }
                        
                  
                        if let status = character.status {
                            DisclosureGroup("Status (Spoiler Alert!): ") {
                                VStack(alignment: .leading) {
                                    Text(status)
                                        .font(.title2)
                                        .padding(5)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    if let death = character.death,
                                       let image = death.image,
                                       let deathURL = URL(string:  image) {
                                        AsyncImage(url: deathURL) { image in
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        if let how = death.details {
                                            Text("How: \(how)")
                                                .padding(.bottom, 5)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        
                                        if let lastWords = death.lastWords {
                                            Text("Last words: \" \(lastWords)\"")
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity,alignment: .leading)
                            }
                            .tint(.primary)
                        }
                      }
                      .frame(maxWidth: min(geo.size.width * 0.8, 600), alignment: .leading)
                      .padding(.bottom, 80)
                    
                }
                .scrollIndicators(.hidden)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: "Breaking Bad")
}
