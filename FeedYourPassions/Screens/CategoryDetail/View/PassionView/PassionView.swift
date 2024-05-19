//
//  PassionView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 27/04/24.
//

import Meteor
import SwiftUI
import Factory
import FirebaseFirestore

struct PassionView: View {

    @Environment(\.openURL) private var openURL
    @Environment(\.alerterKey) var alerter

    @StateObject var viewModel: PassionViewModel
    let barColor: Color

    var body: some View {
        HStack(spacing: 0) {
            avatarView

            VStack(spacing: 0) {
                HStack(spacing: 8) {
                    VStack(spacing: 4) {
                        latestUpdateLabel
                        title
                    }
                    .padding(.vertical, 8)

                    VStack(spacing: 0) {
                        Spacer()
                        MIconButton(type: .accentGhost, size: .small, image: Image(systemName: "plus")) {
                            print("tap on plus")
                        }
                        .padding(12)
                        Spacer()
                    }
                    .background(Color.mBackgroundDark)
                }
            }
        }
        .background(Color.mBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
        .shadow(radius: 8)
        .onChange(of: viewModel.alertContainer) { old, new in
            alerter.alert = new?.alert
        }
        .contextMenu(ContextMenu(menuItems: {
            let url = viewModel.associatedURL
            Button {
                if let url { openURL(url) }
            } label: {
                Label("Open", systemImage: "link")
            }
            .disabled(url == nil)

            Button {
                // ZAPTODO: implement image customization
                print("Edit Picture: missing implementation")
            } label: {
                Label("Edit Picture", systemImage: "pencil.tip.crop.circle")
            }

            Button {
                // ZAPTODO: implement image customization
                print("Edit Title: missing implementation")
            } label: {
                Label("Edit Title", systemImage: "character.cursor.ibeam")
            }
        }))
    }

    private var avatarView: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(viewModel.color ?? Color.mGetPaletteColor(.pink, forListIndex: Int.random(in: 0..<5)))
            .stroke(Color.mBorder, lineWidth: 2)
            .frame(width: 48, height: 64)
            .padding(12)
    }

    private var title: some View {
        Text(viewModel.passion.name)
            .font(.body.weight(.semibold))
            .foregroundStyle(Color.mLightText)
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
    }

    private var latestUpdateLabel: some View {
        HStack(spacing: 6) {
            Text("\(viewModel.passion.recordsCount)")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(Color.mAccent)
                .lineLimit(1)
            Circle()
                .fill(Color.mAccentDark)
                .frame(width: 3, height: 3)
                .clipShape(Capsule())
            Text(viewModel.latestUpdateString)
                .font(.caption2.weight(.medium))
                .foregroundStyle(Color.mAccentDark)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
    }
}

#if DEBUG
#Preview {
    VStack {
        Spacer()
        PassionView(
            viewModel: .init(
                passion: .init(
                    name: "Passion",
                    associatedURL: "some",
                    recordsCount: 0,
                    latestUpdate: Timestamp(date: Date())
                )
            ),
            barColor: Color.red
        )
        Spacer()
    }
    .background(Color.mBackground)
}
#endif
