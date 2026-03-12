//
//  DriveDetailView.swift
//  Formual 1 drivers list
//
//  Created by daniell Escareno on 3/11/26.
//

import SwiftUI

struct DriverDetailView: View {
    // This tells the view: "Expect to be handed a Driver when you open!"
    let driver: Driver
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // --- HEADER ---
                VStack(alignment: .leading, spacing: 4) {
                    Text(driver.name)
                        .font(.system(size: 36, weight: .heavy))
                    
                    Text(driver.currentTeam)
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // --- FAST FACTS ---
                HStack {
                    VStack(alignment: .leading) {
                        Text("AGE")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text("\(driver.age)")
                            .font(.headline)
                    }
                    
                    Spacer()
                    
                    if let nickname = driver.nicknames.first {
                        VStack(alignment: .trailing) {
                            Text("NICKNAME")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                            Text("\"\(nickname)\"")
                                .font(.headline)
                                .italic()
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                // --- BACKGROUND ---
                VStack(alignment: .leading, spacing: 8) {
                    Text("Background")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(driver.background)
                        .font(.body)
                        .lineSpacing(4)
                }
                
                // --- ACCOMPLISHMENTS ---
                VStack(alignment: .leading, spacing: 8) {
                    Text("Accomplishments")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(driver.accomplishments)
                        .font(.body)
                        .lineSpacing(4)
                }
                // Figiure out how to add this without AI
//                VStack(alignment: .leading, spacing: 8) {
//                    Text("Previus Teams")
//                        .font(.title3)
//                        .fontWeight(.bold)
//                    Text(driver.previousTeams)
//                        .font(.body)
//                        .lineSpacing(4)
//                }
                
            }
            .padding()
        }
        // This puts their name small at the top of the screen
        .navigationTitle(driver.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
