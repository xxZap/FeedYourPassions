//
//  CategoryView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI
import Meteor

struct CategoryView: View {
    let category: CategoryContainer
    let maxValue: Int
    let color: Color
    let selected: Bool

    var body: some View {
        VStack(spacing: 8) {
            Text(category.passionCategory.extendedName)
                .font(.body.weight(.semibold))
                .foregroundStyle(selected ? Color.mDarkText : Color.mLightText)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            MProgressView(value: category.maxValue, total: maxValue, color: color, height: 44)
        }
    }
}

#if DEBUG
#Preview("\(CategoryView.self)") {
    VStack {
        Spacer()
        CategoryView(
            category: CategoryContainer(passionCategory: PassionCategory(type: .family), maxValue: 0),
            maxValue: 10,
            color: Color.mGetPaletteColor(.red, forListIndex: 1),
            selected: false
        )
        Spacer()
    }
    .background(Color.mBackground)
}
#endif
