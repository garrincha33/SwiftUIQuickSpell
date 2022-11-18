//
//  ContentView.swift
//  SwiftUIQuickSpell
//
//  Created by Richard Price on 16/11/2022.
//

import SwiftUI

struct ContentView: View {
    //step 4 change this to a normal empty letter array
    @State private var unusedLetters = [Letter]()
    @State private var usedLetters = [Letter]()
    @State private var dictionary = Set<String>()
    @Namespace private var animation
    
    //MARK: GAME LOGIC
    //step 1 create some local state to store timer and score
    //and if game is over
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var time = 0
    @State private var score = 0
    @State private var usedWords = Set<String>()
    @State private var isGameOver = false
    
    var body: some View {
        VStack {
            //step 9 add a spacer
            Spacer()
            HStack {
                ForEach(usedLetters) { letter in
                    LetterView(letter: letter, color: wordIsValid() ? .green : .red, onTap: remove)
                        .matchedGeometryEffect(id: letter, in: animation)
                    
                }
            }
            //step 9 add a spacer
            Spacer()
            HStack {
                ForEach(unusedLetters) { letter in
                    LetterView(letter: letter, color: .yellow, onTap: add)
                        .matchedGeometryEffect(id: letter, in: animation)
                }
            }
            //step 7 add score go button and time
            HStack {
                Spacer()
                Text("Time: \(time)")
                Spacer()
                     Button("Go", action: submit)
                    .disabled(wordIsValid() == false)
                    .opacity(wordIsValid() ? 1 : 0.33)
                    .bold()
                Spacer()
                Text("Score: \(score)")
                Spacer()
            }
            .padding(.vertical, 5)
            .monospacedDigit()
            .font(.title)
        }
        .padding().onAppear(perform: load)
        //step 10
        .background(.blue.gradient)
        //step 8 count down the timer
        .onReceive(timer) { _ in
            if time == 0 {
                isGameOver = true
            } else {
                time -= 1
            }
        }
    }
    
    func load() {
        guard let url = Bundle.main.url(forResource: "text", withExtension: "txt") else { return }
        guard let contents = try? String(contentsOf: url) else { return }
        dictionary = Set(contents.components(separatedBy: .newlines))
        //step 3 create a new game here
        newGame()
    }
    
    func add(_ letter: Letter) {
        guard let index = unusedLetters.firstIndex(of: letter) else { return }
        withAnimation(.spring()) {
            unusedLetters.remove(at: index)
            usedLetters.append(letter)
        }
        
    }
    
    func remove(_ letter: Letter) {
        guard let index = usedLetters.firstIndex(of: letter) else { return }
        withAnimation(.spring()) {
            usedLetters.remove(at: index)
            unusedLetters.append(letter)
        }

    }
    func wordIsValid() -> Bool {
        let word = usedLetters.map(\.character).joined().lowercased()
        //step 6 check if word is already used
        guard usedWords.contains(word) == false else { return false }
        return dictionary.contains(word)
    }
    //step 2 create a function for a new game
    func newGame() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        isGameOver = false
        score = 0
        time = 30
        unusedLetters = (0..<9).map { _ in Letter()}
        usedLetters.removeAll()
    }
    
    //step 5 a function to submit the word
    func submit() {
        guard wordIsValid() else { return }
        withAnimation {
            let word = usedLetters.map(\.character).joined().lowercased()
            usedWords.insert(word)
            score += usedLetters.count * unusedLetters.count
            time += usedLetters.count * 2
            
            unusedLetters.append(contentsOf: (0..<unusedLetters.count).map { _ in Letter() })
            usedLetters.removeAll()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
