//
//  ContentView.swift
//  Formual 1 drivers list
//
//  Created by daniell Escareno on 3/9/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DriverViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if let errorMsg = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.red)
                        Text("Pit Stop Required!")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(errorMsg)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                } else {
                    
                    // --- THE NORMAL LIST SCREEN ---
                    List(viewModel.drivers) { driver in
                        NavigationLink {
                            DriverDetailView(driver: driver)
                        } label: {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(driver.name)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Text(driver.currentTeam)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                HStack {
                                    Text("Age: \(driver.age)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Spacer()
                                    if let firstNickname = driver.nicknames.first {
                                        Text("\"\(firstNickname)\"")
                                            .font(.caption)
                                            .italic()
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("2026 F1 Grid")
        }
    }
}

#Preview {
    ContentView()
}
