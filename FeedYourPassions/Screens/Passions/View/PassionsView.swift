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

let mockedGroups: [PassionGroup] = [
    PassionGroup(
        name: "Max",
        passions: [
            Passion(name: "max", currentValue: 16)
        ]
    ),
    PassionGroup(
        name: "Music",
        passions: [
            Passion(name: "Spotify", currentValue: 7),
            Passion(name: "Concerts", currentValue: 0)
        ]
    ),
    PassionGroup(
        name: "Restaurants",
        passions: [
            Passion(name: "Sushi", currentValue: 4),
            Passion(name: "Pizza", currentValue: 2)
        ]
    ),
    PassionGroup(
        name: "Sport",
        passions: [
            Passion(name: "Gym", currentValue: 5),
            Passion(name: "Run", currentValue: 0),
            Passion(name: "Trekking 0~500m", currentValue: 4),
            Passion(name: "Trekking 501~1000m", currentValue: 1)
        ]
    ),
    PassionGroup(
        name: "Reading",
        passions: [
            Passion(name: "Manga", currentValue: 3),
            Passion(name: "Books", currentValue: 0)
        ]
    ),
    PassionGroup(
        name: "TV",
        passions: [
            Passion(name: "Anime", currentValue: 2),
            Passion(name: "TV Series", currentValue: 5),
            Passion(name: "Movies", currentValue: 0)
        ]
    ),
    PassionGroup(
        name: "Teather",
        passions: [
            Passion(name: "Opera", currentValue: 0),
            Passion(name: "Commedia", currentValue: 1)
        ]
    ),
    PassionGroup(
        name: "Friends",
        passions: [
            Passion(name: "Events", currentValue: 2)
        ]
    ),
    PassionGroup(
        name: "Family",
        passions: [
            Passion(name: "Family events", currentValue: 2)
        ]
    ),
    PassionGroup(
        name: "Videogames",
        passions: [
            Passion(name: "League Of Legends", currentValue: 3),
            Passion(name: "Dragon's Dogma 2", currentValue: 3),
            Passion(name: "E-Football", currentValue: 0),
        ]
    ),
    PassionGroup(
        name: "Min",
        passions: [
            Passion(name: "minimum", currentValue: 0)
        ]
    ),
]
