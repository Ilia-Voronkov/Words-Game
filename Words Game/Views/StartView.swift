//made with youtube chanel MadiSpace

import SwiftUI

struct startView: View {
   @State var bigWord = ""
    @State var player1 = ""
    @State var player2 = ""
    
    @State var isShowGame = false
    @State var isAlertPrsented = false
    

    var body: some View {
        VStack {
            
        TitleText(text: "Words Game")
            
            WordTextField(word: $bigWord, placeHolder: "Enter the word")
                .padding(20)
                .padding(.top, 32)
            
            WordTextField(word: $player1, placeHolder: "Player 1")
                .padding(.horizontal, 20)
                .padding(.top, 42)
            
            WordTextField(word: $player2, placeHolder: "Player 2")
                .cornerRadius(12)
                .padding(.horizontal, 20)


            Button {
                if bigWord.count > 7 {
                    isShowGame.toggle()
                } else {
                    self.isAlertPrsented.toggle()
                }
            } label: {
                Text("Start")
                    .font(.custom("AvenirNext-Bold", size: 32))
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 64)
                    .background(Color("firstPlayer"))
                    .cornerRadius(14)
                    .padding(.top, 40)
            }

            
            
        }.background(Image("background"))
            .alert("This word is too short", isPresented: $isAlertPrsented, actions: {
                Text("Ok!")
            })
            .fullScreenCover(isPresented: $isShowGame) {
                
                let name1 = player1 == "" ? "Player 1" : player1
                let name2 = player2 == "" ? "Player 2" : player2
                
                let player1 = Player(name: name1)
                let player2 = Player(name: name2)
                
                
                
                let GameViewModel = GameViewModel(player1: player1, player2: player2, word: bigWord)
                
                GameView(viewModel: GameViewModel)
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        startView()
    }
}
