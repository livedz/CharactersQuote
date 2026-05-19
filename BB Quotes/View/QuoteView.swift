//
//  QuoteView.swift
//  BB Quotes
//
//  Created by MOKSHA on 05/04/26.
//
import SwiftUI

struct QuoteView: View {
    let vm = ViewModel()
    let show: String
    @State var showCharacterInfo = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                let backgroundImage = show == "Breaking Bad" ? "Image1" : "Image2"
                Image(backgroundImage)
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
                        case .success:
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
                        }
                        Spacer()
                    }
                    .navigationDestination(isPresented: $showCharacterInfo) {
                        CharacterView(character: vm.character, show: show)
                    }
                    Button {
                        Task {
                            await vm.getData(for: show)
                        }
                    } label : {
                        Text("Get Random Quote")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.defaultGreen)
                        .clipShape(.rect(cornerRadius: 8))
                        .shadow(color: .defaultYellow, radius: 2)
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
    QuoteView(show: "Breaking Bad")
        .preferredColorScheme(.dark)
}
