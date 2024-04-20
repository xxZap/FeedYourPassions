//
//  DesignSystem.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI

enum FYPColor {

    static let background = Color(#colorLiteral(red: 0.2509803922, green: 0.2392156863, blue: 0.3803921569, alpha: 1))
    static let backgroundDark = Color(#colorLiteral(red: 0.1921568627, green: 0.1725490196, blue: 0.3137254902, alpha: 1))
    static let accent = Color(#colorLiteral(red: 0.9019607843, green: 0.7647058824, blue: 0.5764705882, alpha: 1))
    static let lightText = Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))

    static let bars: [Color] = [
        Color(#colorLiteral(red: 0.9411764706, green: 0.5019607843, blue: 0.5019607843, alpha: 1)),
        Color(#colorLiteral(red: 0.9568627451, green: 0.5921568627, blue: 0.5568627451, alpha: 1)),
        Color(#colorLiteral(red: 0.9725490196, green: 0.6784313725, blue: 0.6156862745, alpha: 1)),
        Color(#colorLiteral(red: 0.9843137255, green: 0.768627451, blue: 0.6705882353, alpha: 1)),
        Color(#colorLiteral(red: 1, green: 0.8549019608, blue: 0.7254901961, alpha: 1))
    ]

    static func getColor(forListIndex index: Int) -> Color {
        Self.bars[index % Self.bars.count]
    }
}
