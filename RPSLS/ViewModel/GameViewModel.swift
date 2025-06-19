//
//  GameViewModel.swift
//  RPSLS
//
//  Created by Aviran Dabush on 19/06/2025.
//

import SwiftUI
import AVFoundation

@MainActor
class GameViewModel: ObservableObject {
    @Published var playerChoice: Choice?
    @Published var computerChoice: Choice?
    @Published var result: String = ""
    @Published var playerScore = 0
    @Published var computerScore = 0
    @Published var animatePlayer = false
    @Published var animateComputer = false
    @Published var showResult = false

    private var audioPlayer: AVAudioPlayer?

    func play(_ choice: Choice) {
        playerChoice = choice
        computerChoice = Choice.allCases.randomElement()
        animatePlayer = true
        animateComputer = true
        showResult = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.animatePlayer = false
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.animateComputer = false
            self.determineResult()
        }
    }

    func determineResult() {
        guard let player = playerChoice, let computer = computerChoice else { return }

        if player == computer {
            result = "It's a tie!"
            playSound(named: "tie")
        } else if win(player, against: computer) {
            result = "You win!"
            playSound(named: "win")
            playerScore += 1
        } else {
            result = "You lose!"
            playSound(named: "lose")
            computerScore += 1
        }

        showResult = true
    }

    func win(_ player: Choice, against opponent: Choice) -> Bool {
        switch (player, opponent) {
        case (.scissors, .paper),
             (.paper, .rock),
             (.rock, .lizard),
             (.lizard, .spock),
             (.spock, .scissors),
             (.scissors, .lizard),
             (.lizard, .paper),
             (.paper, .spock),
             (.spock, .rock),
             (.rock, .scissors):
            return true
        default:
            return false
        }
    }

    func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Could not play sound \(name): \(error.localizedDescription)")
        }
    }

    func resetGame() {
        playerChoice = nil
        computerChoice = nil
        result = ""
        playerScore = 0
        computerScore = 0
        showResult = false
    }
}
