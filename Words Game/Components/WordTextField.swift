//
//  WordTextField.swift
//  Words Game
//
//  Created by Admin on 05.05.2022.
//

import SwiftUI

struct WordTextField: View {
    @State var word: Binding<String>
    var placeHolder: String
    var body: some View {
        
        
        TextField(placeHolder, text: word)
            .font(.title2)
            .padding()
            .background(.white)
            .cornerRadius(12)

    }
}
