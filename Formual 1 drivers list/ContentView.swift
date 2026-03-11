//
//  ContentView.swift
//  Formual 1 drivers list
//
//  Created by daniell Escareno on 3/9/26.
//

import SwiftUI
import Combine

// MARK: - Main Views

struct ContentView: View {
    @StateObject private var viewModel = DriverViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Fetching the Grid...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    DriverListView(drivers: viewModel.drivers)
                }
            }
            .navigationTitle("F1 Drivers 2026")
            .task {
                if viewModel.drivers.isEmpty {
                    await viewModel.fetchDrivers()
                }
            }
        }
    }
}

// MARK: - Extracted List Components

struct DriverListView: View {
    let drivers: [Driver]
    
    var body: some View {
        List(drivers) { driver in
            NavigationLink(destination: DriverDetailView(driver: driver)) {
                DriverRowView(driver: driver)
            }
        }
    }
}

struct DriverRowView: View {
    let driver: Driver
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(driver.fullName)
                .font(.headline)
            Text(driver.nationality)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Extracted Detail Components

struct DriverDetailView: View {
    let driver: Driver
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                DriverHeaderView(driver: driver)
                Divider()
                DriverBioView(driver: driver)
                Divider()
                DriverStoryView(driver: driver)
                Spacer()
            }
            .padding()
        }
        .navigationTitle(driver.givenName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DriverHeaderView: View {
    let driver: Driver
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(driver.fullName)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("\(driver.nationality) • \(driver.careerStatus)")
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
}

struct DriverBioView: View {
    let driver: Driver
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            DetailRow(title: "Date of Birth", value: driver.dateOfBirth)
            

        }
    }
}

struct DriverStoryView: View {
    let driver: Driver
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("The Road to F1")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(driver.originStory)
                .font(.body)
                .foregroundColor(.secondary)
                .italic()
                .padding(.top, 4)
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text("\(title):")
                .fontWeight(.semibold)
            Text(value)
            Spacer()
        }
    }
}

// MARK: - ViewModel

@MainActor
class DriverViewModel: ObservableObject {
    @Published var drivers: [Driver] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    func fetchDrivers() async {
        isLoading = true
        guard let url = URL(string: "https://api.jolpi.ca/ergast/f1/drivers.json?limit=50") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(MRDataResponse.self, from: data)
            self.drivers = decodedResponse.MRData.DriverTable.Drivers
        } catch {
            self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}

#Preview {
    ContentView()
}
