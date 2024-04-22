//
//  PassionsGroup.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import Foundation

struct OPassionsGroup: Equatable {
    var name: String
    var passions: [OPassion]

    var currentValue: Int {
        passions.isEmpty ? 0 : passions.map { $0.records.count }.reduce(0, +)
    }
}

let mockedGroups: [OPassionsGroup] = [
    OPassionsGroup(
        name: "Max",
        passions: [
            OPassion(
                name: "max",
                associatedURL: nil,
                records: (0..<100).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionsGroup(
        name: "Music",
        passions: [
            OPassion(
                name: "Spotify",
                associatedURL: "https://open.spotify.com",
                records: (0..<7).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Concerts",
                associatedURL: nil,
                records: (0..<1).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionsGroup(
        name: "Restaurants",
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
    OPassionsGroup(
        name: "Sport",
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
                records: (0..<1).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionsGroup(
        name: "Reading",
        passions: [
            OPassion(
                name: "Manga",
                associatedURL: nil,
                records: (0..<3).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Books",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionsGroup(
        name: "TV",
        passions: [
            OPassion(
                name: "Anime",
                associatedURL: nil,
                records: (0..<2).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "TV Series",
                associatedURL: nil,
                records: (0..<5).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Movies",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionsGroup(
        name: "Teather",
        passions: [
            OPassion(
                name: "Opera",
                associatedURL: nil,
                records: (0..<0).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Commedia",
                associatedURL: nil,
                records: (0..<1).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionsGroup(
        name: "Friends",
        passions: [
            OPassion(
                name: "Events",
                associatedURL: nil,
                records: (0..<2).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionsGroup(
        name: "Family",
        passions: [
            OPassion(
                name: "Family events",
                associatedURL: nil,
                records: (0..<2).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionsGroup(
        name: "Videogames",
        passions: [
            OPassion(
                name: "League of Legends",
                associatedURL: nil,
                records: (0..<100).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "Dragon's Dogma 2",
                associatedURL: nil,
                records: (0..<100).map { _ in OPassionRecord(date: Date()) }
            ),
            OPassion(
                name: "E-Football",
                associatedURL: nil,
                records: (0..<100).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
    OPassionsGroup(
        name: "Min",
        passions: [
            OPassion(
                name: "Minimum",
                associatedURL: nil,
                records: (0..<100).map { _ in OPassionRecord(date: Date()) }
            )
        ]
    ),
]
