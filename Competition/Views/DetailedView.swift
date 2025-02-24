//
//  DetailedView.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import SwiftUI

struct DetailedView: View {
    let lastMatch: CompetitionAttributes.DisplayMatch?
    let nextMatch: CompetitionAttributes.DisplayMatch?
    let teamNextMatch: CompetitionAttributes.DisplayMatch?

    var body: some View {
        VStack (spacing: 0) {
            if let match = lastMatch {
                MatchView(match: match, longName: "Last Match")
            }
//            if let match = nextMatch {
//                MatchView(match: match)
//            }
            if let match = teamNextMatch {
                MatchView(match: match, longName: "Next Up")
            }
        }.padding(EdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20))
    }
}

#Preview {
    DetailedView(
        lastMatch: CompetitionAttributes.DisplayMatch(
            name: "Q1",
            scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(),
            redAlliance: CompetitionAttributes.Alliance(
                team1: "2654E", team2: "2145Z", score: 22),
            blueAlliance: CompetitionAttributes.Alliance(
                team1: "ABS", team2: "ABCD", score: 44)),
        nextMatch: CompetitionAttributes.DisplayMatch(
            name: "Q2",
            scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(),
            redAlliance: CompetitionAttributes.Alliance(
                team1: "2654E", team2: "2145Z", score: nil),
            blueAlliance: CompetitionAttributes.Alliance(
                team1: "ABS", team2: "ABCD", score: nil)),
        teamNextMatch: CompetitionAttributes.DisplayMatch(
            name: "Q4",
            scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(),
            redAlliance: CompetitionAttributes.Alliance(
                team1: "2654E", team2: "2145Z", score: nil),
            blueAlliance: CompetitionAttributes.Alliance(
                team1: "ABS", team2: "ABCD", score: nil)))
}
