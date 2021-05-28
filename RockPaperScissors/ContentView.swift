//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Alexander Bonney on 4/25/21.
//

import SwiftUI

struct ContentView: View {
    let conditions = ["Rock", "Paper", "Scissors"]
    let tasks = ["win", "lose"]
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var task = Bool.random()
    @State private var scoreNumber = 0
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var questionsCount = 0
    
    var taskFactory: String {
        if task {
            return "win"
        } else {
            return "lose"
        }
    }
    
    var body: some View {
        VStack {
            Text("Result: \(scoreTitle)")
            Text("Computer's choice is \(conditions[computerChoice])")
            Text("Your task is to \(taskFactory)")
            HStack {
                ForEach(0..<conditions.count) { choice in
                    Button(action: {
                        buttonTapped(choice)
                    }, label: {
                        Text("\(conditions[choice])")
                    })
                }
            }
        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text("Game over"), message: Text("Your score is \(scoreNumber) of 10"), dismissButton: .default(Text("Continue")) {
                self.newGame()
            })
        })
    }
    
    func showAlert() {
        if questionsCount == 10 {
            showingScore = true
        }
    }
    
    func winOrNot(_ number: Int) -> Bool {
        if computerChoice == 0, number == 1 {
            return true
        } else if computerChoice == 1, number == 2 {
            return true
        } else if computerChoice == 2, number == 0 {
            return true
        }
        return false
    }
    
    func buttonTapped(_ number: Int) {
        if winOrNot(number) == task {
            questionsCount += 1
            scoreNumber += 1
            scoreTitle = "Correct"
        }  else {
            questionsCount += 1
            scoreTitle = "Incorrect"
            scoreNumber -= 1
            if scoreNumber < 0 {
                scoreNumber = 0
            }
        }
        task = Bool.random()
        computerChoice = Int.random(in: 0...2)
        showAlert()
    }
    
    func newGame() {
        computerChoice = Int.random(in: 0...2)
        task = Bool.random()
        scoreTitle = ""
        scoreNumber = 0
        questionsCount = 0
    }
    
    
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
