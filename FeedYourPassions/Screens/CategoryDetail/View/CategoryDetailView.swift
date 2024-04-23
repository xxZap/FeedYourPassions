//
//  CategoryDetailView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 23/04/24.
//

import SwiftUI
import Combine
import Meteor

class CategoryDetailViewModel: ObservableObject {
    var category: OPassionCategory

    init(category: OPassionCategory) {
        self.category = category
    }
}

struct CategoryDetailView: View {

    @ObservedObject var viewModel: CategoryDetailViewModel

    var body: some View {
        List {
            Text(viewModel.category.name)
                .font(.subheadline)
                .foregroundStyle(Color.mLightText)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
        .listStyle(.plain)
        .background(Color.mBackground)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(viewModel.category.name)
    }
}
