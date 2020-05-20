//
//  ContactView.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/19.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

struct ContactView: View {

  @ObservedObject var viewModel = ContactViewModel()
  @EnvironmentObject var root: RootViewModel

  var body: some View {

    ZStack {
      VStack {
        Color("light_gray").frame(height: 300)
        Spacer()
      }

      List {
        Group {
          SearchEntryView()
          ForEach(viewModel.contacts) { contact in
            Section(header: ContactSectionView(contact: contact)) {
              ForEach(contact.members) { member in
                ContactCell(member: member, isLast: contact.members.last?.id == member.id)
                  .navigationLink(destination: ChatView())
              }
            }
          }
        }
      }
    }.onAppear {
      self.root.tabSelection = 1
      self.root.tabNavigationHidden = false
      self.root.tabNavigationTitle = "联系人"
      self.root.tabNavigationBarTrailingItems = .init(Image("person.badge.plus"))
    }
  }
}

struct ContactView_Previews: PreviewProvider {
  static var previews: some View {
    ContactView()
  }
}

struct ContactSectionView: View {
  let contact: Contact

  var body: some View {
    Text(contact.letter)
      .font(.system(size: 16, weight: .medium))
      .foregroundColor(.secondary)
      .padding(EdgeInsets(top: 2, leading: -8, bottom: 2, trailing: 6))
  }
}

struct ContactCell: View {

  let member: Member
  let isLast: Bool

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Image(member.icon)
          .renderingMode(.original)
          .resizable()
          .frame(width: 48, height: 48)
          .cornerRadius(8)

        Text(member.name)
          .font(.system(size: 14, weight: .regular))
          .foregroundColor(.primary)
      }
      if !isLast {
        Separator().padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 0))
      }
    }.padding(.leading, -8)
  }
}


