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
        HStack(alignment: .center, spacing: 8) {
            avatarView

            VStack(spacing: 4) {
                title
                subtitle
            }
            .frame(minHeight: 60)
            .padding(.leading, 8)

            counter
        }
        .padding(8)
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
        Circle()
            .fill(Color.mBackgroundDark)
            .frame(width: 44, height: 44)
    }

    private var counter: some View {
        HStack(alignment: .center, spacing: 8) {
            Text("\(viewModel.passion.recordsCount)")
                .font(.body.weight(.bold))
                .foregroundStyle(Color.mLightText)
                .multilineTextAlignment(.trailing)
                .lineLimit(1)
                .frame(alignment: .trailing)

            MIconButton(type: .ghost, size: .small, image: Image(systemName: "plus")) {
//                viewModel.addRecord()
            }
        }
        .padding(8)
        .padding(.leading, 8)
        .background(Color.mBackgroundDark.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
    }

    private var title: some View {
        Text(viewModel.passion.name)
            .font(.body.weight(.semibold))
            .foregroundStyle(Color.mLightText)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var subtitle: some View {
        Text(viewModel.latestUpdateString)
            .font(.footnote)
            .foregroundStyle(Color.mLightText)
            .multilineTextAlignment(.leading)
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
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
