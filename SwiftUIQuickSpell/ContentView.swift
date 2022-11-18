//
//  ContentView.swift
//  SwiftUIQuickSpell
//
//  Created by Richard Price on 16/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var unusedLetters = (0..<9).map { _ in Letter()}
    @State private var usedLetters = [Letter]()
    @State private var dictionary = Set<String>()
    //step 5 one step further with the animation using a namespace
    @Namespace private var animation
    
    var body: some View {
        //step 3 add in the color param
        VStack {
            HStack {
                ForEach(usedLetters) { letter in
                    LetterView(letter: letter, color: wordIsValid() ? .green : .red, onTap: remove)
                    //step 6 add in a matchedGeometry effect
                        .matchedGeometryEffect(id: letter, in: animation)
                    
                }
            }
            
            HStack {
                ForEach(unusedLetters) { letter in
                    LetterView(letter: letter, color: .yellow, onTap: add)
                    //step 6 add in a matchedGeometry effect
                        .matchedGeometryEffect(id: letter, in: animation)
                }
            }
        }
        
        .padding().onAppear(perform: load)
    }
    
    func load() {
        guard let url = Bundle.main.url(forResource: "text", withExtension: "txt") else { return }
        guard let contents = try? String(contentsOf: url) else { return }
        dictionary = Set(contents.components(separatedBy: .newlines))
    }
    
    func add(_ letter: Letter) {
        guard let index = unusedLetters.firstIndex(of: letter) else { return }
        //step 4 add some animation
        withAnimation(.spring()) {
            unusedLetters.remove(at: index)
            usedLetters.append(letter)
        }
        
    }
    
    func remove(_ letter: Letter) {
        guard let index = usedLetters.firstIndex(of: letter) else { return }
        //step 4 add some animation
        withAnimation(.spring()) {
            usedLetters.remove(at: index)
            unusedLetters.append(letter)
        }

    }
    
    //step 1 check if a word is valid
    func wordIsValid() -> Bool {
        let word = usedLetters.map(\.character).joined().lowercased()
        return dictionary.contains(word)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
