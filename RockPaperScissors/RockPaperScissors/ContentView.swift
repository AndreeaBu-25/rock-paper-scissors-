//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Andreea Bucsa on 11.04.2025.
//

import SwiftUI

struct Buttons: ViewModifier
{
    func body(content: Content) -> some View
    {
        content
            .font(.title2)
            .foregroundStyle(.white)
            .padding(7)
            //.background(Color(red: 0.8, green: 0.6, blue: 0.8))
            .background(.black)
            .clipShape(.rect(cornerRadius: 10))
    }
}

struct ContentView: View
{
    let moves = ["🪨", "📄", "✂️"]
    
    @State private var currentChoice = ""
    @State private var winLose = ""
    @State private var playerChoice = ""
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View
    {
        ZStack
        {
            LinearGradient(colors: [.gray, .white], startPoint: .top, endPoint: .bottom)
            //ignoresSafeArea()
                .ignoresSafeArea()
            
            VStack(spacing: 15)
            {
                Spacer()
                Spacer()
                Spacer()
                Text("Rock, Paper, Scissors")
                    .font(.largeTitle.bold())
                Spacer()
                
                Button("GO")
                {
                    provideInput()
                }
                .modifier(Buttons())
                
                Spacer()
                Text("\(currentChoice)\(winLose)")
                    .font(.title)
                Spacer()
                Text("\(playerChoice)")
                    .font(.title)
                
                VStack(spacing: 70)
                {
                   
                    Spacer()
                    Spacer()
                    HStack(spacing: 50)
                    {
                        Button("🪨")
                        {
                            playerChoice = "🪨"
                            
                            switch currentChoice
                            {
                            case "🪨":
                                score = score
                            case "📄":
                                showingScore = true
                                if winLose == " + you must win"
                                {
                                    score -= 1
                                    scoreTitle = "Wrong"
                                }
                                else
                                {
                                    score += 1
                                    scoreTitle = "Right!"
                                }
                            case "✂️":
                                showingScore = true
                                if winLose == " + you must win"
                                {
                                    score += 1
                                    scoreTitle = "Right!"
                                }
                                else
                                {
                                    score -= 1
                                    scoreTitle = "Wrong"
                                }
                            default:
                                score = 0
                            }
                        }
                        .font(.largeTitle)
                        .shadow(radius: 10)
                        
                        Button("📄")
                        {
                            playerChoice = "📄"
                            
                            switch currentChoice
                            {
                            case "🪨":
                                showingScore = true
                                if winLose == " + you must win"
                                {
                                    score += 1
                                    scoreTitle = "Right!"
                                }
                                else
                                {
                                    score -= 1
                                    scoreTitle = "Wrong"
                                }
                            case "📄":
                                score = score
                            case "✂️":
                                showingScore = true
                                if winLose == " + you must win"
                                {
                                    score -= 1
                                    scoreTitle = "Wrong"
                                }
                                else
                                {
                                    score += 1
                                    scoreTitle = "Right!"
                                }
                                
                            default:
                                score = 0
                            }
                        }
                        .font(.largeTitle)
                        .shadow(radius: 10)
                        
                        Button("✂️")
                        {
                            playerChoice = "✂️"
                            
                            switch currentChoice
                            {
                            case "🪨":
                                showingScore = true
                                if winLose == " + you must win"
                                {
                                    score -= 1
                                    scoreTitle = "Wrong"
                                }
                                else
                                {
                                    score += 1
                                    scoreTitle = "Right!"
                                }
                            case "📄":
                                showingScore = true
                                if winLose == " + you must win"
                                {
                                    score += 1
                                    scoreTitle = "Right!"
                                }
                                else
                                {
                                    score -= 1
                                    scoreTitle = "Wrong"
                                }
                            case "✂️":
                                score = score
                            default:
                                score = 0
                            }
                        }
                        .font(.largeTitle)
                        .shadow(radius: 10)
                    }
                    Text("Score: \(score)")
                    
                    Button("Reset game")
                    {
                        gameRestart()
                    }
                    .foregroundStyle(.white)
                    .padding(7)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore)
        {
            Button("Close", action: provideInput)
        }message:
        {
            if scoreTitle == "Wrong"
            {
                Text("Wrong answer. Your score is \(score)")
            }
            if scoreTitle == "Right!"
            {
                Text("That's right! Your score is \(score)")
            }
        }
        
        .alert("Game over! Your final score is \(score)", isPresented: $restartGame)
        {
            Button("Restart game", action: gameRestart)
        }
    }
    
    @State private var checkEndGame = -1
    @State private var restartGame = false
    func provideInput()
    {
        checkEndGame += 1
        
        let i = Int.random(in: 0...2)
        let outcome = Bool.random()
        
        currentChoice = moves[i]
        
        //outcome.toggle()
        
        if outcome == true
        {
            winLose = " + you must win"
        }else
        {
            winLose = " + you must lose"
        }
        if checkEndGame == 5
        {
            restartGame = true
        }
    }
    func gameRestart()
    {
        restartGame = false
        checkEndGame = -1
        
        currentChoice = ""
        winLose = ""
        playerChoice = ""
        score = 0
        showingScore = false
        scoreTitle = ""
    }
}

#Preview
{
    ContentView()
}
