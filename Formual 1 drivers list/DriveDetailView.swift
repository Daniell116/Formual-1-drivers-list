//
//  DriveDetailView.swift
//  Formual 1 drivers list
//
//  Created by daniell Escareno on 3/11/26.
//

import SwiftUI

struct DriverDetailView: View {
    let driver: Driver
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 4) {
                    // names the driver that was selected with their current team
                    Text(driver.name)
                        .font(.system(size: 36, weight: .heavy))
                    Text(driver.currentTeam)
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
                Divider()
                HStack {
                    // gives the drivers age
                    VStack(alignment: .leading) {
                        Text("AGE")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        Text("\(driver.age)")
                            .font(.headline)
                    }
                    Spacer()
                    // any nicknames they mave have from fans
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
                //Gives a short background about them
                VStack(alignment: .leading, spacing: 8) {
                    Text("Background")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(driver.background)
                        .font(.body)
                        .lineSpacing(4)
                }
                // Their best accopmishment
                VStack(alignment: .leading, spacing: 8) {
                    Text("Accomplishments")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(driver.accomplishments)
                        .font(.body)
                        .lineSpacing(4)
                }
                
            }
            .padding()
        }
        //Puts their name on top of the screen
        .navigationTitle(driver.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

