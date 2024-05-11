//
//  OPassionsGroup.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation

class PassionCategory: Equatable, Hashable, Codable {
    let type: PassionCategoryType
    var passions: [Passion]

    var currentValue: Int {
        passions.isEmpty ? 0 : passions.map { $0.records.count }.reduce(0, +)
    }

    var maxValue: Int {
        passions.map { $0.records.count }.max() ?? 0
    }

    init(type: PassionCategoryType, passions: [Passion]) {
        self.type = type
        self.passions = passions
    }

    static func == (lhs: PassionCategory, rhs: PassionCategory) -> Bool {
        lhs.type == rhs.type
        && lhs.passions == rhs.passions
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(passions)
    }
}

let mockedCategories: [PassionCategory] = [
    PassionCategory(
        type: .music,
//        name: "🎵 Music",
        passions: [
            Passion(
                name: "Spotify",
                associatedURL: "https://open.spotify.com",
                records: (0..<8).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Concerts",
                associatedURL: nil,
                records: (0..<1).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionCategory(
        type: .food,
//        name: "🍴 Food",
        passions: [
            Passion(
                name: "Sushi",
                associatedURL: nil,
                records: (0..<4).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Pizza",
                associatedURL: nil,
                records: (0..<1).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionCategory(
        type: .sport,
//        name: "🏅 Sport",
        passions: [
            Passion(
                name: "Gym",
                associatedURL: nil,
                records: (0..<5).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Run",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Trekking 0~500m",
                associatedURL: nil,
                records: (0..<4).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Trekking 501~1000m",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionCategory(
        type: .health,
//        name: "❤️ Health",
        passions: [
            Passion(
                name: "Dentist",
                associatedURL: nil,
                records: (0..<2).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Medical Examinations",
                associatedURL: nil,
                records: (0..<2).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Spa",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionCategory(
        type: .reading,
//        name: "📖 Reading",
        passions: [
            Passion(
                name: "Manga",
                associatedURL: nil,
                records: (0..<11).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Books",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionCategory(
        type: .tv,
//        name: "📺 TV",
        passions: [
            Passion(
                name: "Anime",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "TV Series",
                associatedURL: nil,
                records: (0..<5).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Movies",
                associatedURL: nil,
                records: (0..<1).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Cinema",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Netflix",
                associatedURL: "nflx://www.netflix.com",
                records: (0..<2).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionCategory(
        type: .theater,
//        name: "🎭 Theater",
        passions: [
            Passion(
                name: "Opera",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Commedia",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionCategory(
        type: .friends,
//        name: "😆 Friends",
        passions: [
            Passion(
                name: "Friends events",
                associatedURL: nil,
                records: (0..<2).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionCategory(
        type: .family,
//        name: "🏡 Family",
        passions: [
            Passion(
                name: "Family events",
                associatedURL: nil,
                records: (0..<2).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionCategory(
        type: .videogames,
//        name: "🎮 Videogames",
        passions: [
            Passion(
                name: "League of Legends",
                associatedURL: nil,
                records: (0..<1).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Dragon's Dogma 2",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "E-Football",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionCategory(
        type: .personal,
//        name: "🛠️ Personal projects",
        passions: [
            Passion(
                name: "App",
                associatedURL: nil,
                records: (0..<6).map { _ in PassionRecord(date: Date()) }
            )
        ]
    ),
    PassionCategory(
        type: .travel,
//        name: "✈️ Travel",
        passions: [
            Passion(
                name: "Africa",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Antarctica",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Asia",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Europe",
                associatedURL: nil,
                records: (0..<2).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "Oceania",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "North America",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            ),
            Passion(
                name: "South America",
                associatedURL: nil,
                records: (0..<0).map { _ in PassionRecord(date: Date()) }
            )
        ]
    )
]

enum PassionCategoryType: String, Codable, CaseIterable {
    case music
    case food
    case sport
    case health
    case reading
    case tv
    case theater
    case friends
    case family
    case personal
    case videogames
    case travel
}
