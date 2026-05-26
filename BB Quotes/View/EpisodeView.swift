//
//  EpisodeView.swift
//  BB Quotes
//
//  Created by MOKSHA on 20/05/26.
//
import SwiftUI

struct EpisodeView: View {
    let episode: Episode
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(episode.title)
                .font(.largeTitle)
            
            Text(episode.seasonepisode)
                .font(.title2)
            
            if let episodeImage = episode.image {
                AsyncImage(url: URL(string: episodeImage)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 15))
                    
                } placeholder: {
                    ProgressView()
                }
            }
            if let synopsis = episode.synopsis {
                Text(synopsis)
                    .font(.title3)
                    .minimumScaleFactor(0.5)
                    .padding(.bottom)
            }
            
            if let writtenBy = episode.writtenBy {
                Text("Written by: \(writtenBy)")
            }
            
            if let directedBy = episode.directedBy {
                Text("Directed by: \(directedBy)")
            }
            
            if let airDate = episode.airDate {
                Text("Aired: \(airDate)")
            }
            
        }
        .padding()
        .foregroundStyle(.white)
        .background(.black.opacity(0.6))
        .clipShape(.rect(cornerRadius: 25))
        .padding(.horizontal)
    }
}

#Preview {
    EpisodeView(episode: ViewModel().episodeDetails)
}
