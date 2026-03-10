//
//  DriverModels.swift
//  Formual 1 drivers list
//
//  Created by daniell Escareno on 3/10/26.
//

import Foundation
import SwiftUI
import Combine // This is the magic framework that powers ObservableObject

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

// MARK: - Main Driver Model
struct Driver: Codable, Identifiable {
    let driverId: String
    let givenName: String
    let familyName: String
    let dateOfBirth: String
    let nationality: String
    
    var id: String { driverId }
    var fullName: String { "\(givenName) \(familyName)" }
    
    // MARK: - Merging API data with Local Data
    private var localBio: DriverBio? {
        return localDriverBios[driverId]
    }
    
    var careerStatus: String {
        localBio?.careerStatus ?? "Status Unknown"
    }
    
    var isDeceased: Bool {
        localBio?.isDeceased ?? false
    }
    
    var dateOfDeath: String? {
        localBio?.dateOfDeath
    }
    
    var causeOfDeath: String? {
        localBio?.causeOfDeath
    }
    
    var originStory: String {
        localBio?.originStory ?? "Story currently unavailable. Check back later to learn how \(givenName) made it to Formula 1!"
    }
}
