//
//  DriverModels.swift
//  Formual 1 drivers list
//
//  Created by daniell Escareno on 3/10/26.
//

import Foundation
import SwiftUI
import Combine // This is the magic framework that powers ObservableObject

@MainActor
class DriverViewModel: ObservableObject {
    @Published var drivers: [Driver] = []
    
    // 1. Add this variable to hold any error text
    @Published var errorMessage: String? = nil
    
    init() {
        loadDrivers()
    }
    func loadDrivers() {
        guard let url = Bundle.main.url(forResource: "Drivers", withExtension: "json") else {
            // 2. Set the error instead of just printing it
            self.errorMessage = "Could not find the drivers.json file in the app bundle. Make sure it's spelled correctly!"
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedDrivers = try JSONDecoder().decode([Driver].self, from: data)
            self.drivers = decodedDrivers
            
            // If it succeeds, make sure the error message is cleared
            self.errorMessage = nil
            
        } catch {
            // 3. Catch decoding errors (like a typo in the JSON file)
            self.errorMessage = "Failed to read the driver data: \(error.localizedDescription)"
        }
    }
}
// MARK: - API Decoding Structs
struct MRDataResponse: Codable {
    let MRData: MRData
}
struct MRData: Codable {
    let DriverTable: DriverTable
}
struct DriverTable: Codable {
    let Drivers: [Driver]
}
struct Driver: Codable, Identifiable {
    let driverId: String
    let name: String
    let currentTeam: String
    let birthDate: String
    let age: Int
    let previousTeams: [String]
    let nicknames: [String]
    let background: String
    let accomplishments: String
    
    // SwiftUI needs an 'id' to make lists work, so we just use the driverId!
    var id: String { driverId }
}
