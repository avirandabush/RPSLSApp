//
//  GameView.swift
//  RPSLS
//
//  Created by Aviran Dabush on 19/06/2025.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Rock Paper Scissors Lizard Spock")
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)

            HStack(spacing: 15) {
                ForEach(Choice.allCases) { choice in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.animatePlayer = true
                        }
                        viewModel.play(choice)
                    }) {
                        Text(choice.rawValue)
                            .font(.system(size: 40))
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.primary, lineWidth: 2)
                            )
                    }
                    .rotationEffect(viewModel.animatePlayer && viewModel.playerChoice == choice ? .degrees(20) : .degrees(0))
                    .scaleEffect(viewModel.animatePlayer && viewModel.playerChoice == choice ? 1.3 : 1.0)
                    .animation(.easeInOut(duration: 0.3), value: viewModel.animatePlayer)
                }
            }

            if let player = viewModel.playerChoice, let computer = viewModel.computerChoice {
                VStack {
                    Text("You: \(player.rawValue)")
                        .font(.title)
                        .scaleEffect(viewModel.animatePlayer ? 1.2 : 1.0)
                        .animation(.spring(), value: viewModel.animatePlayer)

                    Text("Computer: \(computer.rawValue)")
                        .font(.title)
                        .rotationEffect(viewModel.animateComputer ? .degrees(360) : .degrees(0))
                        .animation(.easeIn(duration: 0.5), value: viewModel.animateComputer)
                }

                if viewModel.showResult {
                    Text(viewModel.result)
                        .font(.title2)
                        .bold()
                        .transition(.opacity)
                        .animation(.easeIn, value: viewModel.showResult)
                }
            }

            HStack {
                Text("You: \(viewModel.playerScore)")
                Spacer()
                Text("Computer: \(viewModel.computerScore)")
            }
            .padding()
            .font(.headline)

            Button("Reset Game") {
                viewModel.resetGame()
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.red, lineWidth: 2)
            )
            .foregroundColor(.red)
            .padding(.top)
        }
        .padding()
    }
}

#Preview {
    GameView()
}
