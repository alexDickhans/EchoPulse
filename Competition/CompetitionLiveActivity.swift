//
//  CompetitionLiveActivity.swift
//  Competition
//
//  Created by Alexander Dickhans on 2/22/25.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct CompetitionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CompetitionAttributes.self) { context in
            // Lock screen/banner UI goes here
            DetailedView(lastMatch: context.state.lastMatch, nextMatch: context.state.nextMatch, teamNextMatch: context.state.teamNextMatch, teamNumber: context.attributes.teamName)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    if let match = context.state.lastMatch {
                        SmallMatchView(match: match, longName: "Last Match").padding(EdgeInsets(top: -10, leading: 12, bottom: -10, trailing: 0))
                    }
                }
                DynamicIslandExpandedRegion(.center) {
                    Ranking(rank: 1, num: 80).frame(maxHeight: .infinity, alignment: .center)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    if let match = context.state.nextMatch {
                        SmallMatchView(match: match, longName: "Next Match").padding(EdgeInsets(top: -10, leading: 0, bottom: -10, trailing: 12))
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    if let match = context.state.teamNextMatch {
                        MatchView(match: match, longName: "Next Up", teamName: context.attributes.teamName)
                    }
                }
            } compactLeading: {
                if let match = context.state.lastMatch {
                    MinimalMatchView(match: match)
                }
            } compactTrailing: {
                if let match = context.state.teamNextMatch {
                    MinimalMatchView(match: match)
                }
            } minimal: {
                if let match = context.state.lastMatch {
                    MinimalMatchView(match: match)
                } else if let match = context.state.nextMatch {
                    MinimalMatchView(match: match)
                }
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension CompetitionAttributes {
    static var preview: CompetitionAttributes {
        CompetitionAttributes(name: "World", teamName: "2654E", division: "Science")
    }
}

extension CompetitionAttributes.ContentState {
    static var sad: CompetitionAttributes.ContentState {
        CompetitionAttributes.ContentState(lastMatch: CompetitionAttributes.DisplayMatch(name: "R16 1-1", scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(), redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "2145Z", score: 22), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: 44)), nextMatch: CompetitionAttributes.DisplayMatch(name: "Q2", scheduled: Date().addingTimeInterval(-60 * 2), startTime: nil, redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "2145Z", score: nil), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: nil)), teamNextMatch: CompetitionAttributes.DisplayMatch(name: "Q4", scheduled: Date().addingTimeInterval(-60 * 2), startTime: nil, redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "2145Z", score: nil), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: nil)))
    }
    
    static var smiley: CompetitionAttributes.ContentState {
        CompetitionAttributes.ContentState(lastMatch: CompetitionAttributes.DisplayMatch(name: "R16 8-2", scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(), redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "2145Z", score: 44), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: 22)), nextMatch: CompetitionAttributes.DisplayMatch(name: "Q2", scheduled: Date().addingTimeInterval(-60 * 2), startTime: nil, redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "2145Z", score: nil), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: nil)), teamNextMatch: CompetitionAttributes.DisplayMatch(name: "Q4", scheduled: Date().addingTimeInterval(-60 * 2), startTime: nil, redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "88888W", score: nil), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: nil)))
    }
    
    static var pout: CompetitionAttributes.ContentState {
        CompetitionAttributes.ContentState(lastMatch: nil, nextMatch: CompetitionAttributes.DisplayMatch(name: "Q2", scheduled: Date().addingTimeInterval(-60 * 2), startTime: nil, redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "88888W", score: nil), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: nil)), teamNextMatch: CompetitionAttributes.DisplayMatch(name: "Q4", scheduled: Date().addingTimeInterval(-60 * 2), startTime: nil, redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "88888W", score: nil), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: nil)))
    }
}

#Preview("Live Activity", as: .content, using: CompetitionAttributes.preview) {
    CompetitionLiveActivity()
} contentStates: {
    CompetitionAttributes.ContentState.sad
    CompetitionAttributes.ContentState.smiley
    CompetitionAttributes.ContentState.pout
}
