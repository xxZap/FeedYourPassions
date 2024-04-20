//
//  FYPProgressView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI

struct FYPProgressView: View {
    let value: Float
    let total: Float
    let color: Color
    let height: CGFloat
    private var percentage: CGFloat {
        CGFloat((total == 0 ? 0 : value / total).clamped(to: 0...1))
    }

    init(value: Int, total: Int, color: Color, height: CGFloat = 32) {
        self.value = Float(value)
        self.total = Float(total)
        self.color = color
        self.height = height
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(FYPColor.backgroundDark)
                .frame(maxWidth: .infinity)

            ZStack {
                GeometryReader { geoProxy in
                    HStack(spacing: 0) {
                        Capsule()
                            .fill(color)
                            .offset(x: -geoProxy.size.width + geoProxy.size.width * percentage)
                        Spacer(minLength: 0)
                    }
                }
            }
            .overlay {
                GeometryReader { geoProxy in
                    let divisors = 5
                    HStack(spacing: 0) {
                        ForEach(0..<divisors, id: \.self) { index in
                            bigSeparator
                            if index < divisors - 1 {
                                HStack(spacing: 0) {
                                    Spacer()
                                    smallSeparator
                                    Spacer()
                                    smallSeparator
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, geoProxy.size.height / 2)
                    .frame(height: geoProxy.size.height)
                }
            }
        }
        .frame(height: height)
        .clipShape(.capsule)
    }

    private var smallSeparator: some View {
        Circle()
            .fill(Color.white)
            .frame(width: 2, height: 2)
    }

    private var bigSeparator: some View {
        Circle()
            .stroke(Color.white, lineWidth: 4)
            .fill(FYPColor.accent)
            .frame(width: 4, height: 4)
    }
}

private extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

#if DEBUG
#Preview("\(FYPProgressView.self)") {
    VStack {
        Spacer()
        FYPProgressView(value: 2, total: 60, color: FYPColor.getColor(forListIndex: 2))
        Spacer()
    }
    .padding()
    .background(FYPColor.background)
}
#endif
