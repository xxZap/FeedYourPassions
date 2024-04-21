//
//  PassionsGroupView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI

struct PassionGroupView: View {
    let passiongGroup: PassionGroup
    let maxValue: Int
    let color: Color
    let action: (() -> Void)

    var body: some View {
        Button(
            action: { action() },
            label: {
                VStack(spacing: 8) {
                    Text(passiongGroup.name)
                        .font(.body.weight(.semibold))
                        .foregroundStyle(FYPColor.lightText)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    FYPProgressView(value: passiongGroup.currentValue, total: maxValue, color: color)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        )
        .buttonStyle(FYPPressable())
    }
}

#if DEBUG
#Preview("\(PassionGroupView.self)") {
    VStack {
        Spacer()
        PassionGroupView(
            passiongGroup: PassionGroup(
                name: "Group",
                passions: [
                    Passion(
                        name: "Spotify",
                        associatedURL: "https://open.spotify.com",
                        records: (0..<7).map { _ in PassionRecord(date: Date()) }
                    )
                ]
            ),
            maxValue: 10,
            color: FYPColor.getColor(forListIndex: 1)
        ) {
        }
        Spacer()
    }
    .background(FYPColor.background)
}
#endif
