//
//  ContentView.swift
//  Formual 1 drivers list
//
//  Created by daniell Escareno on 3/9/26.
//

import SwiftUI

struct ContentView: View {
    @State private var drivers: [Driver] = []
    @State private var errorMessage: String?
    var body: some View {
        NavigationStack {
            if let error = errorMessage {
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.red)
                    Text("Failed to load drivers")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(error)
                        .foregroundStyle(.secondary)
                }
            } else {
                List(drivers) { driver in
                    NavigationLink {
                        DriverDetailView(driver: driver)
                    } label: {
                        VStack(alignment: .leading) {
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
                                Image(driver.teamLogo)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Image("\(driver.number)")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                if let nickname = driver.nicknames.first {
                                    Text("\"\(nickname)\"")
                                        .font(.caption)
                                        .italic()
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("2026 F1 Grid")
                .task {
                    await loadDrivers()
                }
            }
        }
    }
    
    func loadDrivers() async {
        guard let url = URL(string: "https://api.npoint.io/bb9dc797eb0662d93782") else {
            errorMessage = "Invalid URL"
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let decodedDrivers = try JSONDecoder().decode([Driver].self, from: data)
            drivers = decodedDrivers
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load drivers: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}

