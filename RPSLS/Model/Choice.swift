//
//  Choice.swift
//  RPSLS
//
//  Created by Aviran Dabush on 19/06/2025.
//

import Foundation

enum Choice: String, CaseIterable, Identifiable {
    case rock = "🪨"
    case paper = "📄"
    case scissors = "✂️"
    case lizard = "🦎"
    case spock = "🖖"

    var id: String { rawValue }
}
