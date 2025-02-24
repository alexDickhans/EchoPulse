//
//  CompetitionAttributes.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import ActivityKit
import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.count > index ? self[index] : nil
    }
}

struct CompetitionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        public let lastMatch: DisplayMatch?
        public let nextMatch: DisplayMatch?
        public let teamNextMatch: DisplayMatch?

        public static func fromMatchList(
            displayMatches: [DisplayMatch], teamName: String
        ) -> Self {
            var lastScoredIndex: Int = 0
            var teamNextMatch: Int = 0
            var matchesSkipped: Bool = true

            for (index, match) in displayMatches.enumerated() {
                if match.redAlliance.score != nil {
                    lastScoredIndex = index
                } else {
                    matchesSkipped = false
                }

                if [
                    match.redAlliance.team1, match.redAlliance.team2,
                    match.blueAlliance.team1, match.blueAlliance.team2,
                ].contains(where: { (team: String?) -> Bool in team == teamName
                    })
                {
                    teamNextMatch = index

                    if !matchesSkipped {
                        break
                    }
                }
            }

            return ContentState(
                lastMatch: displayMatches[safe: lastScoredIndex],
                nextMatch: displayMatches[safe: lastScoredIndex + 1],
                teamNextMatch: displayMatches[safe: teamNextMatch])
        }
    }

    public struct DisplayMatch: Codable, Hashable {
        public let name: String
        public let scheduled: Date?
        public let startTime: Date?
        public let redAlliance: Alliance
        public let blueAlliance: Alliance

        public static func fromRoboScoutMatch(match: Match) -> Self {
            var red_score: Int? = nil
            var blue_score: Int? = nil

            if match.started != nil || match.red_score != 0
                || match.blue_score != 0
            {
                red_score = match.red_score
                blue_score = match.blue_score
            }

            return DisplayMatch(
                name: match.name.replacingOccurrences(
                    of: "[a-z#]", with: "", options: .regularExpression),
                scheduled: match.scheduled,
                startTime: match.started,
                redAlliance: CompetitionAttributes.Alliance.fromRoboScoutTeams(
                    teams: match.red_alliance, score: red_score),
                blueAlliance: CompetitionAttributes.Alliance.fromRoboScoutTeams(
                    teams: match.blue_alliance, score: blue_score))
        }
    }

    public struct Alliance: Codable, Hashable {
        public let team1: String
        public let team2: String?
        public let score: Int?

        public static func fromRoboScoutTeams(teams: [Team], score: Int?)
            -> Self
        {
            return Alliance(
                team1: teams[0].number,
                team2: teams.count > 1 ? teams[1].number : nil, score: score)
        }
    }

    public let name: String
    public let division: String
}
