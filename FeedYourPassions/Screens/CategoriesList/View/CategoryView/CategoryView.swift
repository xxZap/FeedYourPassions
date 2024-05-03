//
//  CategoryView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI
import Meteor

struct CategoryView: View {
    let category: OPassionCategory
    let maxValue: Int
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Text(category.name)
                .font(.body.weight(.semibold))
                .foregroundStyle(Color.mLightText)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            MProgressView(value: category.currentValue, total: maxValue, color: color, height: 44)
        }
    }
}

#if DEBUG
#Preview("\(CategoryView.self)") {
    VStack {
        Spacer()
        CategoryView(
            category: OPassionCategory(
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
            color: Color.mGetPaletteColor(.red, forListIndex: 1)
        )
        Spacer()
    }
    .background(Color.mBackground)
}
#endif
