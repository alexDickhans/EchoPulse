//
//  DetailedView.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import SwiftUI

struct DetailedView: View {
    let lastMatch: CompetitionAttributes.Match?
    let nextMatch: CompetitionAttributes.Match?
    let teamNextMatch: CompetitionAttributes.Match?

    var body: some View {
        VStack {
            if let match = lastMatch {
                MatchView(match: match)
            }
            if let match = nextMatch {
                MatchView(match: match)
            }
            if let match = teamNextMatch {
                MatchView(match: match)
            }
        }
    }
}

#Preview {
    DetailedView(
        lastMatch: CompetitionAttributes.Match(
            name: "Q1", scored: true,
            scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(),
            redAlliance: CompetitionAttributes.Alliance(
                team1: "2654E", team2: "2145Z", score: 22),
            blueAlliance: CompetitionAttributes.Alliance(
                team1: "ABS", team2: "ABCD", score: 44)),
        nextMatch: CompetitionAttributes.Match(
            name: "Q2", scored: true,
            scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(),
            redAlliance: CompetitionAttributes.Alliance(
                team1: "2654E", team2: "2145Z", score: nil),
            blueAlliance: CompetitionAttributes.Alliance(
                team1: "ABS", team2: "ABCD", score: nil)),
        teamNextMatch: CompetitionAttributes.Match(
            name: "Q4", scored: true,
            scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(),
            redAlliance: CompetitionAttributes.Alliance(
                team1: "2654E", team2: "2145Z", score: nil),
            blueAlliance: CompetitionAttributes.Alliance(
                team1: "ABS", team2: "ABCD", score: nil)))
}
