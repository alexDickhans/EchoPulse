//
//  ContentView.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import ActivityKit
import SwiftUI

// IMPORTANT: LIVE VIEW CAN ONLY SAY ON SCREEN FOR 8 HOURS - maybe
class TeamEvents: ObservableObject {
    @Published var event_indexes: [String]
    @Published var events: [Event]
    
    init(team: Team? = nil) {
        event_indexes = [String]()
        events = [Event]()
        if team == nil {
            return
        }
        team!.fetch_events()
        events = team!.events
        var count = 0
        for _ in events {
            event_indexes.append(String(count))
            count += 1
        }
        event_indexes.reverse()
    }
}

struct ContentView: View {
    @State var activity: Activity<CompetitionAttributes>?
    @State var matchList: [CompetitionAttributes.Match]
    @State var team: String
    @State var competitions: TeamEvents? = nil

    var body: some View {
        NavigationView {
            VStack {
                ZStack (alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                    Color.orange
                                    .frame(height: 100) // Height of the top bar
                                Text("Echo Live")
                                    .foregroundColor(.white) // Text color
                                    .padding().font(.system(size: 18, weight: .heavy))
                }.edgesIgnoringSafeArea(.top)
                ScrollView {
                    VStack {
                        if activity != nil {
                            Button("Stop Activity") {
                                Task {
                                    await stopActivity()
                                }
                            }
                            FullDetailedView(
                                matches: matchList, teamName: team)
                        } else {
                            TextField("2654E", text: $team).frame(alignment: .center).multilineTextAlignment(.center).font(.system(size: 36))
                            Button("Search") {
                                findCompetitions()
                            }
                            buildCompetitionsList()
                        }
                    }.buttonStyle(.borderedProminent).controlSize(.large)
                }
            }.edgesIgnoringSafeArea(.top)
        }

    }
    
    func buildCompetitionsList() -> some View {
        VStack(spacing: 0) {
            Group {
                if let events = competitions?.events {
                    ForEach(events, id: \.id) { competition in
                        Button(action: startActivity) {
                            Text(competition.name)
                        }
                    }
                }
            }
        }
    }
    
    func findCompetitions() {
        let fetched_team = Team(number: self.team)
        let fetched_events = TeamEvents(team: fetched_team)
        
        Task {
            self.competitions = fetched_events
        }
    }

    func startActivity() {
        let attributes = CompetitionAttributes.preview
        let state = ActivityContent(
            state: CompetitionAttributes.ContentState.pout,
            staleDate: Date().addingTimeInterval(60))

        do {
            activity = try Activity<CompetitionAttributes>.request(
                attributes: attributes, content: state, pushType: nil)
        } catch {
            print(error.localizedDescription)
        }
    }

    func stopActivity() async {
        await activity?.end(
            ActivityContent(
                state: CompetitionAttributes.ContentState.smiley, staleDate: nil
            ), dismissalPolicy: ActivityUIDismissalPolicy.immediate)

        activity = nil
    }

    init() {
        team = ""
        matchList = []
    }
}

#Preview {
    ContentView()
}
