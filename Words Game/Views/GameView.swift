//
//  GameView.swift
//  Words Game
//
//  Created by Admin on 05.05.2022.
//

import SwiftUI

struct GameView: View {
    
    @State private var word = ""
    @State private var confirmPresent = false
    var viewModel: GameViewModel
    @State private var isAlertPresent = false
    @State var alertText = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button {
                    confirmPresent.toggle()
                } label: {
                    Text("Quit")
                        .padding()
                        .padding(.horizontal)
                        .background(Color("Orange"))
                        .cornerRadius(16)
                        .padding(6)
                        .foregroundColor(.white)
                        .font(.custom("AvenirNext-Bold", size: 18))
            }
                
                Spacer()
            }
            
            Text(viewModel.word)
                .font(.custom("AvenirNext-Bold", size: 30))
                .foregroundColor(.white)

            
            HStack(spacing: 12) {
                
                VStack{
                    Text("\(viewModel.player1.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text("\(viewModel.player1.name)")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                }.padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color("firstPlayer"))
                    .cornerRadius(16)
                    .shadow(color: viewModel.isFirst ? .red : .clear, radius: 4, x: 0, y: 0)
                
                
                VStack{
                    Text("\(viewModel.player2.score)")
                        .font(.custom("AvenirNext-Bold", size: 60))
                        .foregroundColor(.white)
                    Text("\(viewModel.player1.name)")
                        .font(.custom("AvenirNext-Bold", size: 24))
                        .foregroundColor(.white)
                }.padding(20)
                    .frame(width: screen.width / 2.2, height: screen.width / 2.2)
                    .background(Color("secondPlayer"))
                    .cornerRadius(16)
                    .shadow(color: viewModel.isFirst ? .green : .clear, radius: 4, x: 0, y: 0)

            }
            
            WordTextField(word: $word, placeHolder: "Your Word is...")
                .padding(.horizontal)
            
            Button {
                
                
                var score = 0
                do {
                    try score = viewModel.check(word: word)
                } catch WordError.beforeWord {
                    alertText = "Show your imagination! Come up with a new word that has not been composed before."
                    isAlertPresent.toggle()
                } catch WordError.littleWord {
                    alertText = "To short a word."
                    isAlertPresent.toggle()
                } catch WordError.theSameWord {
                    alertText = "Do you think you're the smartest?! The compound word must not be original word."
                    isAlertPresent.toggle()
                } catch WordError.wrongWord {
                    alertText = "Such a word cannot be composed"
                    isAlertPresent.toggle()
                } catch {
                    alertText = "Unknown error"
                    isAlertPresent.toggle()
                }
                if score > 1 {
                    self.word = ""
                }
            } label: {
                Text("Ready!")
                    .padding(12)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color("Orange"))
                    .cornerRadius(12)
                    .font(.custom("AvenirNext-Bold", size: 36))
                    .padding(.horizontal)
                
            }
            List {
                ForEach(0 ..< self.viewModel.words.count, id: \.description) { item in
                    WordCell(word: self.viewModel.words[item])
                        .background(item % 2 == 0 ? Color("firstPlayer") : Color("secondPlayer"))
                        .listRowInsets(EdgeInsets())
                    
                }
            }.listStyle(.plain)
                .frame( maxWidth: .infinity, maxHeight: .infinity)


        }.background(Image("background"))
            .confirmationDialog("Are you sure want to complete the game",
                                isPresented: $confirmPresent,
                                titleVisibility: .visible) {
                Button(role: .destructive) {
                    self.dismiss()
                } label: {
                    Text("Yes")
                }
                
                Button(role: .cancel) {
                } label: {
                    Text("No")
                }

            }
             .alert(alertText, isPresented: $isAlertPresent) {
                 Text("OK")
                                }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(player1: Player(name: "Ilia"), player2: Player(name: "Julia"), word: "Абстрактивный"))
    }
}
