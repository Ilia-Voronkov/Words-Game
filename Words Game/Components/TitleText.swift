//
//  TitleText.swift
//  Words Game
//
//  Created by Admin on 05.05.2022.
//

import SwiftUI

struct TitleText: View {
    @State var text: String

    var body: some View {
        
        Text(text)
            .padding()
            .font(.custom("AvenirNext-Bold", size: 42))
            .cornerRadius(16)
            .frame(maxWidth: .infinity)
            .background(Color("firstPlayer"))
            .foregroundColor(.white)
        
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(text: "Магнитотерапия")
    }
}
