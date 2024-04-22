//
//  PassionsGroupView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI
import Meteor

struct PassionGroupView: View {
    let passiongGroup: OPassionsGroup
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
                        .foregroundStyle(Color.mLightText)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    MProgressView(value: passiongGroup.currentValue, total: maxValue, color: color)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
        )
        .buttonStyle(MPressable())
    }
}

#if DEBUG
#Preview("\(PassionGroupView.self)") {
    VStack {
        Spacer()
        PassionGroupView(
            passiongGroup: OPassionsGroup(
                name: "Group",
                passions: [
                    OPassion(
                        name: "Spotify",
                        associatedURL: "https://open.spotify.com",
                        records: (0..<7).map { _ in OPassionRecord(date: Date()) }
                    )
                ]
            ),
            maxValue: 10,
            color: Color.mGetColor(forListIndex: 1)
        ) {
        }
        Spacer()
    }
    .background(Color.mBackground)
}
#endif
