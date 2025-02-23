//
//  Ranking.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import SwiftUI

struct Ranking: View {
    let rank: Int
    let num: Int
    
    var body: some View {
        Text(String(format: "Rank %d", rank, num)).bold()
    }
}

#Preview {
    Ranking(rank: 1, num: 80)
}
