//
//  SupportedApplicationsController.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 07/06/24.
//

import Meteor
import SwiftUI
import Combine

enum SupportedApplication: CaseIterable {

    // Apple Services
    case appleTV
    case contacts
    case facetimeAudio
    case facetimeVideo
    case garageband
    case iBooks
    case iMovie
    case podcastsBrowse

    // Third-Party Apps & Services
    case achievement
    case ageOfSolitaire
    case bejeweledBlitz
    case clashOfClans
    case drawSomething
    case genshinImpact
    case github
    case goodreads
    case hboGo
    case hboNow
    case hulu
    case instagram
    case netflix
    case rivian
    case sleepTown
    case snapchat
    case spotify
    case tesla
    case tumblr
    case twitch
    case vimeo
    case vlc
    case vsco
    case waze
    case youtube

    struct Info {
        var displayName: String
        var image: Image?
        var appUrl: String
    }

    var info: Info {
        switch self {
            // Apple Services
        case .appleTV:
            return .init(displayName: "Apple TV", image: nil, appUrl: "videos://")
        case .contacts:
            return .init(displayName: "Contacts", image: nil, appUrl: "contacts://")
        case .facetimeAudio:
            return .init(displayName: "FaceTime (Audio)", image: nil, appUrl: "facetime-audio://phoneoremail")
        case .facetimeVideo:
            return .init(displayName: "FaceTime (Video)", image: nil, appUrl: "facetime://phoneoremail")
        case .garageband:
            return .init(displayName: "GarageBand", image: nil, appUrl: "garageband://")
        case .iBooks:
            return .init(displayName: "iBooks", image: nil, appUrl: "ibooks://")
        case .iMovie:
            return .init(displayName: "iMovie", image: nil, appUrl: "imovie://")
        case .podcastsBrowse:
            return .init(displayName: "Podcasts (Browse)", image: nil, appUrl: "pcast://")

            // Third-Party Apps & Services
        case .achievement:
            return .init(displayName: "Achievement - Reward Health", image: nil, appUrl: "achievement://")
        case .ageOfSolitaire:
            return .init(displayName: "Age of Solitaire: Build City", image: nil, appUrl: "fb1431194636974533://")
        case .bejeweledBlitz:
            return .init(displayName: "Bejeweled Blitz", image: nil, appUrl: "com.popcap.ios.BejBlitz://")
        case .clashOfClans:
            return .init(displayName: "Clash of Clans", image: nil, appUrl: "clashofclans://")
        case .drawSomething:
            return .init(displayName: "Draw Something", image: nil, appUrl: "fb225826214141508paid://")
        case .genshinImpact:
            return .init(displayName: "Genshin Impact", image: nil, appUrl: "yuanshengame://")
        case .github:
            return .init(displayName: "GitHub", image: nil, appUrl: "github://")
        case .goodreads:
            return .init(displayName: "Goodreads: Book Reviews", image: nil, appUrl: "goodreads://")
        case .hboGo:
            return .init(displayName: "HBO GO", image: nil, appUrl: "hbogo://")
        case .hboNow:
            return .init(displayName: "HBO NOW", image: nil, appUrl: "hbonow://")
        case .hulu:
            return .init(displayName: "Hulu: Watch TV Shows & Movies", image: nil, appUrl: "hulu://")
        case .instagram:
            return .init(displayName: "Instagram", image: nil, appUrl: "instagram://app")
        case .netflix:
            return .init(displayName: "Netflix", image: nil, appUrl: "nflx://")
        case .rivian:
            return .init(displayName: "Rivian", image: nil, appUrl: "rivian://")
        case .sleepTown:
            return .init(displayName: "SleepTown", image: nil, appUrl: "sleeptown://")
        case .snapchat:
            return .init(displayName: "Snapchat", image: nil, appUrl: "snapchat://")
        case .spotify:
            return .init(displayName: "Spotify Music", image: nil, appUrl: "https://open.spotify.com/")
        case .tesla:
            return .init(displayName: "Tesla", image: nil, appUrl: "tesla://")
        case .tumblr:
            return .init(displayName: "Tumblr", image: nil, appUrl: "tumblr://")
        case .twitch:
            return .init(displayName: "Twitch", image: nil, appUrl: "twitch://")
        case .vimeo:
            return .init(displayName: "Vimeo", image: nil, appUrl: "vimeo://")
        case .vlc:
            return .init(displayName: "VLC", image: nil, appUrl: "vlc://")
        case .vsco:
            return .init(displayName: "VSCO", image: nil, appUrl: "vsco://")
        case .waze:
            return .init(displayName: "Waze Navigation & Live Traffic", image: nil, appUrl: "waze://")
        case .youtube:
            return .init(displayName: "Youtube", image: nil, appUrl: "http://www.youtube.com/")
        }
    }
}

protocol SupportedApplicationsController {
    var supportedApplications: [SupportedApplication?] { get }
}
