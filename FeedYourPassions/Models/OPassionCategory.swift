//
//  OPassionsGroup.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation

typealias OPassionCategoryID = UUID

class OPassionCategory: Equatable, Hashable {
    var id: OPassionCategoryID
    var name: String
    var passions: [OPassion]

    var currentValue: Int {
        passions.isEmpty ? 0 : passions.map { $0.records.count }.reduce(0, +)
    }

    var maxValue: Int {
        passions.map { $0.records.count }.max() ?? 0
    }

    init(name: String, passions: [OPassion]) {
        self.id = OPassionCategoryID()
        self.name = name
        self.passions = passions
    }

    static func == (lhs: OPassionCategory, rhs: OPassionCategory) -> Bool {
        lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.passions.count == rhs.passions.count
        && lhs.passions == rhs.passions
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(passions.count)
        hasher.combine(passions)
    }
}

let mockedCategories: [OPassionCategory] = [
    OPassionCategory(
        name: "🎵 Music",
        passions: [
            OPassion(
                name: "Spotify",
                associatedURL: "https://open.spotify.com",
                records: (0..<8).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Concerts",
                associatedURL: nil,
                records: (0..<1).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "🍴 Food",
        passions: [
            OPassion(
                name: "Sushi",
                associatedURL: nil,
                records: (0..<4).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Pizza",
                associatedURL: nil,
                records: (0..<1).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "🏅 Sport",
        passions: [
            OPassion(
                name: "Gym",
                associatedURL: nil,
                records: (0..<5).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Run",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Trekking 0~500m",
                associatedURL: nil,
                records: (0..<4).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Trekking 501~1000m",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "❤️ Health",
        passions: [
            OPassion(
                name: "Dentist",
                associatedURL: nil,
                records: (0..<2).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Medical Examinations",
                associatedURL: nil,
                records: (0..<2).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Spa",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "📖 Reading",
        passions: [
            OPassion(
                name: "Manga",
                associatedURL: nil,
                records: (0..<11).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Books",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "📺 TV",
        passions: [
            OPassion(
                name: "Anime",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "TV Series",
                associatedURL: nil,
                records: (0..<5).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Movies",
                associatedURL: nil,
                records: (0..<1).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Cinema",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Netflix",
                associatedURL: "nflx://www.netflix.com",
                records: (0..<2).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "🎭 Theater",
        passions: [
            OPassion(
                name: "Opera",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Commedia",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "😆 Friends",
        passions: [
            OPassion(
                name: "Friends events",
                associatedURL: nil,
                records: (0..<2).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "🏡 Family",
        passions: [
            OPassion(
                name: "Family events",
                associatedURL: nil,
                records: (0..<2).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "🎮 Videogames",
        passions: [
            OPassion(
                name: "League of Legends",
                associatedURL: nil,
                records: (0..<1).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Dragon's Dogma 2",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "E-Football",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "🛠️ Personal projects",
        passions: [
            OPassion(
                name: "App",
                associatedURL: nil,
                records: (0..<6).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionCategory(
        name: "✈️ Travel",
        passions: [
            OPassion(
                name: "Africa",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Antarctica",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Asia",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Europe",
                associatedURL: nil,
                records: (0..<2).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Oceania",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "North America",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "South America",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    )
]
