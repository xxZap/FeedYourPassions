//
//  PassionsView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI

struct PassionsView: View {

    let viewModel: PassionsViewModel

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            groupList
            addNewGroupButton
        }
        .background(FYPColor.background)
        .scrollContentBackground(.hidden)
        .navigationTitle("Feed your passions")
        .toolbarBackground(FYPColor.background, for: .navigationBar)
    }

    private var groupList: some View {
        List {
            ForEach(0..<viewModel.groups.count, id: \.self) {
                let group = viewModel.groups[$0]
                PassionGroupView(
                    passiongGroup: group,
                    maxValue: viewModel.maxValue,
                    color: FYPColor.getColor(forListIndex: $0)
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
            Button {
                print("Add a new group")
            } label: {
                Group {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .tint(FYPColor.background)
                        .padding(8)
                        .background(Circle().fill(FYPColor.lightText))
                        .shadow(radius: 8)
                        .padding(16)
                }
            }
            .background(FYPColor.accent)
            .clipShape(.rect(topLeadingRadius: 16, bottomLeadingRadius: 16))
        }
        .padding(.bottom, 8)
        .shadow(radius: 8)
    }
}

#if DEBUG
#Preview("\(PassionsView.self)") {
    PassionsView(viewModel: PassionsViewModel(groups: mockedGroups))
}
#endif
