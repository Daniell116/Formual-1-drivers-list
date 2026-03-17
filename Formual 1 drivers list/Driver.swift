//
//  Driver.swift
//  Formual 1 drivers list
//
//  Created by daniell Escareno on 3/17/26.
//

import Foundation

struct Driver: Codable, Identifiable {
    let driverId: String
    var id: String { driverId }
    let name: String
    let number: Int
    let currentTeam: String
    let teamLogo: String
    let imageName: String
    let age: Int
    let previousTeams: [String]
    let nicknames: [String]
    let background: String
    let accomplishments: String
}
