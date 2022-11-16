//
//  ContentView.swift
//  SwiftUIQuickSpell
//
//  Created by Richard Price on 16/11/2022.
//

import SwiftUI
//step 1 import your list of words into your project
struct ContentView: View {
    
    //step 5 make an array of 8 random letters using map
    //also an array to hold the letters and using a set for the
    //dictionary (sets are lightining fast as they have no dupes
    //and no order
    
    @State private var unusedLetters = (0..<9).map { _ in Letter()}
    @State private var usedLetters = [Letter]()
    @State private var dictionary = Set<String>()
    
    var body: some View {
        VStack {
            HStack {
                ForEach(usedLetters) { letter in
                    LetterView(letter: letter, onTap: remove)
                }
            }
            
            HStack {
                ForEach(unusedLetters) { letter in
                    LetterView(letter: letter, onTap: add)
                }
            }
        }
        
        .padding().onAppear(perform: load)
    }
    
    //step 6 create a function to load the letters
    func load() {
        guard let url = Bundle.main.url(forResource: "text", withExtension: "txt") else { return }
        guard let contents = try? String(contentsOf: url) else { return }
        dictionary = Set(contents.components(separatedBy: .newlines))
    }
    
    //step 7 create a function to add a letter and remove a letter
    func add(_ letter: Letter) {
        guard let index = unusedLetters.firstIndex(of: letter) else { return }
        unusedLetters.remove(at: index)
        usedLetters.append(letter)
    }
    
    func remove(_ letter: Letter) {
        guard let index = usedLetters.firstIndex(of: letter) else { return }
        usedLetters.remove(at: index)
        unusedLetters.append(letter)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
