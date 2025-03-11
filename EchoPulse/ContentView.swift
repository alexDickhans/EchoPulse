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

struct DeviceSubscription : Codable, Hashable {
    let competition_id: Int
    let division_id: Int
    let device_token: String
    let watch_team: String
}

struct DeviceSubscriptionChangeRequest : Codable, Hashable {
    let old_device_token: String
    let new_device_token: String
}

struct LiveActivityStartDetails {
    let name: String
    let error: String
    let id = UUID()
}

struct ContentView: View {
    @State var activity: Activity<CompetitionAttributes>?
    @State var matchList: [CompetitionAttributes.DisplayMatch]
    @State var team: String
    @State var teamID: Int
    @State var competitions: TeamEvents? = nil
    @State var event: Event? = nil
    @State var division: Division? = nil
    @State var lastPushToken: String? = nil
    @State var alertTitle: String = "Testing"
    @State var didError: Bool = false
    @State var startDetails: LiveActivityStartDetails = LiveActivityStartDetails(name: "Test", error: "testing");
    @Environment(\.scenePhase) private var scenePhase
    @State var lastUpdated: Date
    

    var body: some View {
        NavigationView {
            VStack {
                ZStack(
                    alignment: Alignment(horizontal: .center, vertical: .bottom)
                ) {
                    Color.orange
                        .frame(height: 100)  // Height of the top bar
                    Text("Echo Pulse")
                        .foregroundColor(.white)  // Text color
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
                            Text(
                                activity?.attributes.name
                                    ?? "No activity selected")
                            FullDetailedView(
                                matches: matchList, teamName: team.uppercased())
                        } else {
                            TextField("2654E", text: $team).frame(
                                alignment: .center
                            ).multilineTextAlignment(.center).font(
                                .system(size: 36))
                            Button("Search") {
                                findCompetitions()
                            }
                            buildCompetitionsList().buttonStyle(.borderless)
                        }
                    }.buttonStyle(.borderedProminent).controlSize(.large)
                }
            }.edgesIgnoringSafeArea(.top)
        }.alert(
            alertTitle,
            isPresented: $didError,
            presenting: startDetails
        ) { details in
            
        } message: { details in
            Text(details.error)
        }.onChange(of: scenePhase) {
            Task {
                print("appeared")
                
                let activities = Activity<CompetitionAttributes>.activities
                
                if !activities.isEmpty {
                    
                    if scenePhase == .active && Date().timeIntervalSince(lastUpdated) > 30 {
                        self.activity = activities[0]
                        self.team = activity!.attributes.teamName!
                        self.event = Event(id: activity!.attributes.eventId)
                        self.division = Division(id: activity!.attributes.divisionId, name: "")
                        await updateMatchList()
                    }
                } else {
                    self.activity = nil
                    self.division = nil
                    self.event = nil
                }
            }
        }
    }

    func buildCompetitionsList() -> some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal)
            if let events = competitions?.events.reversed() {
                ForEach(events, id: \.id) { competition in
                    Button(action: {
                        self.startActivity(event: competition)
                    }) {
                        Text(competition.name)
                            .font(.headline)
                            .foregroundColor(.orange)  // Text color to indicate action
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)  // Full width button
                    }
                    .buttonStyle(PlainButtonStyle())  // Remove default button style for plain text

                    // Add a line (Divider) between items
                    Divider()
                        .padding(.horizontal)
                }
            }
        }
        .padding(.top)
    }

    func findCompetitions() {
        let fetched_team = Team(number: self.team.uppercased())

        if fetched_team.registered {
            let fetched_events = TeamEvents(team: fetched_team)

            teamID = fetched_team.id

            Task {
                self.competitions = fetched_events
            }
        }
    }

    func startActivity(event: Event) {
        self.event = event

        for division in event.divisions {
            event.fetch_rankings(division: division)

            if event.rankings[division]?.contains(where: {
                $0.team.id == self.teamID
            }) ?? false {
                self.division = division
                break
            }
        }
        
        if self.division == nil {
            print("Could not find division for \(self.team)")
            self.showError(alertTitle: "Unable to find division for \(self.team.uppercased()), likely means the competition isn't started yet.", startDetails: LiveActivityStartDetails(name: "No division", error: ""))
            return
        }
        
        print(self.division)
        
        let attributes = CompetitionAttributes(
            name: event.name, eventId: event.id, divisionId: self.division!.id, teamName: team.uppercased())

        Task {
            await self.updateMatchList()

            let fetch_state = CompetitionAttributes.ContentState.fromMatchList(
                displayMatches: self.matchList, teamName: self.team)

            do {
                self.activity = try Activity<CompetitionAttributes>.request(
                    attributes: attributes, content: .init(state: fetch_state, staleDate: nil), pushType: .token)

                await updateMatchList();
                
                Task {
                    for await pushToken in activity!.pushTokenUpdates {
                        let pushTokenString = pushToken.reduce("") { $0 + String(format: "%02x", $1) }
                        
                        print("New push token: \(pushTokenString)  done")
                        
                        do {
                            try await self.sendPushToken(id: event.id, divisionid: self.division!.id, teamName: self.team, pushTokenString: pushTokenString)
                        } catch {
                            self.showError(alertTitle: "Unable to send push token", startDetails: LiveActivityStartDetails(name: "No division", error: ""))
                            await stopActivity()
                        }
                    }
                }
                
                Task {
                    for await event in activity!.activityStateUpdates {
                        switch event {
                        case .ended:
                            do {
                                try await changePushToken(lastPushToken: lastPushToken!, newPushToken: "")
                                print("sucessfully removed app push token")
                            } catch {
                                print("unable to remove push token: \(error.localizedDescription)")
                                self.showError(alertTitle: "Unable to remove push token, this live activity will not work, try again later.", startDetails: LiveActivityStartDetails(name: "No division", error: ""))
                            }
                        default:
                            break
                        }
                    }
                }
            } catch {
                print(error.localizedDescription)
                showError(alertTitle: "Unable to start live activity ", startDetails: LiveActivityStartDetails(name: "", error: ""))
            }
        }
    }
    
    func sendPushToken(id: Int, divisionid: Int, teamName: String, pushTokenString: String) async throws {
        if let last = lastPushToken {
            try await self.changePushToken(lastPushToken: last, newPushToken: pushTokenString)
        } else {
            let url = URL(string: "https://echoscopebackend.fly.dev" + "/v1/subscribe")
                            
            var urlRequest = URLRequest(url: url!)
            
            urlRequest.httpMethod = "POST"
            
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let device = DeviceSubscription(competition_id: id, division_id: divisionid, device_token: pushTokenString, watch_team: teamName.uppercased())
            
            let encoder = JSONEncoder()
            
            let data = try encoder.encode(device)
                            
            let _ = try await URLSession.shared.upload(for: urlRequest, from: data)
            
            lastPushToken = pushTokenString
        }
    }
    
    func changePushToken(lastPushToken: String, newPushToken: String) async throws {
        let url = URL(string: "https://echoscopebackend.fly.dev" + "/v1/change")
                        
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let device = DeviceSubscriptionChangeRequest(old_device_token: lastPushToken, new_device_token: newPushToken)
        
        let encoder = JSONEncoder()
        
        let data = try encoder.encode(device)
                        
        let _ = try await URLSession.shared.upload(for: urlRequest, from: data)
        
        self.lastPushToken = if newPushToken.isEmpty {nil} else { newPushToken }
    }

    func updateMatchList() async {
        self.event!.fetch_matches(division: self.division!)

        let matches = self.event!.matches[self.division!]!

        var fetched_matches: [CompetitionAttributes.DisplayMatch] = []

        matches.forEach { match in
            fetched_matches.append(
                CompetitionAttributes.DisplayMatch.fromRoboScoutMatch(
                    match: match))
        }

        self.matchList = fetched_matches
        
        self.lastUpdated = Date()
        
        print("updated match list")
    }

    func stopActivity() async {
        await activity?.end(
            ActivityContent(
                state: CompetitionAttributes.ContentState.smiley, staleDate: nil
            ), dismissalPolicy: ActivityUIDismissalPolicy.immediate)
        
        activity = nil
        division = nil
        event = nil
    }
    
    func showError(alertTitle: String, startDetails: LiveActivityStartDetails) {
        didError = true
        
        self.alertTitle = alertTitle
        self.startDetails = startDetails
    }

    init() {
        team = ""
        matchList = []
        teamID = 0
        lastUpdated = Date(timeIntervalSince1970: 0.0)
    }
}

#Preview {
    ContentView()
}
