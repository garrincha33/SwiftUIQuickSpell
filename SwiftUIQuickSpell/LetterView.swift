//
//  LetterView.swift
//  SwiftUIQuickSpell
//
//  Created by Richard Price on 16/11/2022.
//

import SwiftUI

struct LetterView: View {
    let letter: Letter
    var color: Color
    var onTap: (Letter) -> Void
    
    var body: some View {

        Button {
            onTap(letter)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(color.gradient)
                    .frame(height: 60)
                    .frame(minWidth: 30, maxWidth: 60)
                    .shadow(radius: 3)
                
                Text(letter.character)
                    .foregroundColor(.black.opacity(0.65))
                    .font(.largeTitle.bold())
            }
        }
    }
}

struct LetterView_Previews: PreviewProvider {
    static var previews: some View {
        LetterView(letter: Letter(), color: .green) { _ in
            
        }
    }
}
