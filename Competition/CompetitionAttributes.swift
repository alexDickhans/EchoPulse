//
//  CompetitionAttributes.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import Foundation
import ActivityKit

struct CompetitionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        public let lastMatch: Match?
        public let nextMatch: Match?
        public let teamNextMatch: Match?
    }
    
    public struct Match: Codable, Hashable {
        public let name: String
        public let scored: Bool
        public let scheduled: Date?
        public let startTime: Date?
        public let redAlliance: Alliance
        public let blueAlliance: Alliance
    }
    
    public struct Alliance: Codable, Hashable {
        public let team1: String
        public let team2: String?
        public let score: Int?
    }

    public let name: String
    public let division: String
}

