//
//  FetchView.swift
//  BB Quotes
//
//  Created by MOKSHA on 20/05/26.
//

import SwiftUI

struct FetchView: View {
    let vm = ViewModel()
    let showType: TabDetails
    @State var showCharacterInfo = false
    
    private var actionButtonColor: Color {
        switch showType.type {
        case .breakingBad:
            return .defaultGreen
        case .betterCallSaul:
            return .orange
        case .elCamino:
            return .indigo
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(showType.getBackGroundImage())
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                VStack {
                    VStack{
                        Spacer(minLength: 60)
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                        case .fetching:
                            ProgressView()
                        case .successQuote:
                            Text("\"\(vm.quote.quote)\"")
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            if let images = vm.character.images,
                               let charImage = images.first {
                                ZStack(alignment: .bottom) {
                                    AsyncImage(url: URL(string: charImage)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                    Text(vm.quote.character)
                                        .foregroundStyle(.white)
                                        .padding(10)
                                        .frame(maxWidth: .infinity)
                                        .background(.ultraThinMaterial)
                                }
                                .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
                                .clipShape(.rect(cornerRadius: 50))
                                .onTapGesture {
                                    showCharacterInfo.toggle()
                                }
                            }
                        case .failed(let error):
                            Text(error.localizedDescription)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                        case .successEpisode:
                            EpisodeView(episode: vm.episodeDetails)
                        }
                        Spacer()
                    }
                    .navigationDestination(isPresented: $showCharacterInfo) {
                        CharacterView(character: vm.character, showType: showType)
                    }
                    HStack {
                        Button {
                            Task {
                                await vm.getQuoterData(for: showType.getTitle())
                            }
                        } label : {
                            
                            Text("Get Random Quote")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                .background(actionButtonColor)
                                .clipShape(.rect(cornerRadius: 35))
                                .shadow(color: .defaultYellow, radius: 2)
                        }
                        .padding()
                        Button {
                            Task {
                                await vm.getEpisodeData(for: showType.getTitle())
                            }
                        } label : {
                            Text("Get Random Episode")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                .background(actionButtonColor)
                                .clipShape(.rect(cornerRadius: 35))
                                .shadow(color: .defaultYellow, radius: 2)
                        }
                        .padding()
                    }
                    Spacer(minLength: 105)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    FetchView(showType: TabDetails(type: .betterCallSaul))
        .preferredColorScheme(.dark)
}
