//
//  ContentView.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import ActivityKit
import SwiftUI

struct ContentView: View {
    @State var activity: Activity<CompetitionAttributes>?

    var body: some View {
        VStack {
            Button("Start Activity") {
                startActivity()
            }
        }.buttonStyle(.borderedProminent).controlSize(.large)
    }

    func startActivity() {
        let attributes = CompetitionAttributes.preview
        let state = ActivityContent(
            state: CompetitionAttributes.ContentState.smiley, staleDate: nil)

        do {
            activity = try Activity<CompetitionAttributes>.request(
                attributes: attributes, content: state, pushType: nil)
        } catch {
            print(error.localizedDescription)
        }

    }
}

#Preview {
    ContentView()
}
