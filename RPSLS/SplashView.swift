//
//  SplashView.swift
//  RPSLS
//
//  Created by Aviran Dabush on 19/06/2025.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            GameView()
        } else {
            VStack {
                Image(systemName: "gamecontroller.fill")
                    .resizable()
                    .frame(width: 150, height: 100)
                    .padding()

                Text("Welcome to RPSLS Game")
                    .font(.title)
                    .bold()
                
                Text("Rock Paper Scissors Lizard Spock")
                    .padding(.top, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}
