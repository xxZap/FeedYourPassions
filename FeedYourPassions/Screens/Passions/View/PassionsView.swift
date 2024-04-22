//
//  PassionsView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI
import Meteor

struct PassionsView: View {

    let viewModel: PassionsViewModel

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            groupList
            addNewGroupButton
        }
        .background(Color.mBackground)
        .scrollContentBackground(.hidden)
        .navigationTitle("Feed your passions")
        .toolbarBackground(Color.mBackground, for: .navigationBar)
    }

    private var groupList: some View {
        List {
            ForEach(0..<viewModel.groups.count, id: \.self) {
                let group = viewModel.groups[$0]
                PassionGroupView(
                    passiongGroup: group,
                    maxValue: viewModel.maxValue,
                    color: Color.mGetColor(forListIndex: $0)
                ) {
                    print("Tapped on group named \"\(group.name)\"")
                }
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(.init(top: 0, leading: 8, bottom: 0, trailing: 8))

            Rectangle()
                .fill(.clear)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .frame(height: 100)
        }
        .listStyle(.plain)
    }

    private var addNewGroupButton: some View {
        Group {
            MSideButton(
                onTap: {},
                image: Image(systemName: "plus"),
                side: .attachedToTheRight
            )
        }
        .padding(.bottom, 8)
        .shadow(radius: 8)
    }
}

#if DEBUG
#Preview("\(PassionsView.self)") {
    Group {}
    // ZAPTODO: 
//    PassionsView(viewModel: PassionsViewModel(groups: mockedGroups))
}
#endif
