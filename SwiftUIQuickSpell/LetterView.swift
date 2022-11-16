//
//  LetterView.swift
//  SwiftUIQuickSpell
//
//  Created by Richard Price on 16/11/2022.
//

import SwiftUI

struct LetterView: View {
    //step 4 create a some local storage
    let letter: Letter
    var onTap: (Letter) -> Void
    
    
    var body: some View {
        //step 5 create a button using our letter and tap function
        Button {
            onTap(letter)
        } label: {
            Text(letter.character)
                .foregroundColor(.black.opacity(0.65))
                .font(.largeTitle.bold())
        }
    }
}

struct LetterView_Previews: PreviewProvider {
    static var previews: some View {
        LetterView(letter: Letter()) { _ in
            
        }
    }
}
