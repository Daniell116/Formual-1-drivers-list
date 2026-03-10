//
//  DriverBioData.swift
//  Formual 1 drivers list
//
//  Created by daniell Escareno on 3/10/26.
//

import Foundation

// A helper struct to hold our custom local data
struct DriverBio {
    let careerStatus: String
    let isDeceased: Bool
    let dateOfDeath: String?
    let causeOfDeath: String?
    let originStory: String
}

// Our local database of driver stories!
let localDriverBios: [String: DriverBio] = [
    "senna": DriverBio(
        careerStatus: "Legend (Retired)",
        isDeceased: true,
        dateOfDeath: "May 1, 1994",
        causeOfDeath: "Racing accident at the San Marino Grand Prix.",
        originStory: "Senna began karting at age 13. His incredible talent in wet conditions and raw speed quickly pushed him through the junior ranks into F1, where he became a three-time world champion and a Brazilian national hero."
    ),
    "hamilton": DriverBio(
        careerStatus: "Active",
        isDeceased: false,
        dateOfDeath: nil,
        causeOfDeath: nil,
        originStory: "Approaching McLaren boss Ron Dennis at age 10, Lewis famously said, 'I want to race for you one day.' Dennis signed him to the McLaren driver development program, paving the way for his record-breaking career."
    )
]
