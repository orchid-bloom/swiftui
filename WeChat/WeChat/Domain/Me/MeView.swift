//
//  MeView.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/19.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

struct MeView: View {

  @EnvironmentObject var root: RootViewModel
  @ObservedObject var viewModel = MeViewModel()

  var body: some View {
    ZStack {
      VStack {
        Color("cell").frame(height: 300)
        Color("light_gray")
      }
      ScrollView {
        VStack(spacing: 0) {

          Group {
            NavigationLink(destination: LoginView()) {
              Header(member: viewModel.me)
            }
            Line()
          }

          Group {
            Cell(icon: "me_pay", name: "支付")
            Line()
          }

          Group {
            Cell(icon: "me_favorite", name: "收藏")
            Separator().padding(.leading, 52)
            Cell(icon: "me_photo_album", name: "相册")
            Separator().padding(.leading, 52)
            Cell(icon: "me_bank_card", name: "卡包")
            Separator().padding(.leading, 52)
            Cell(icon: "me_emoji", name: "表情")
            Line()
          }

          Group {
            Cell(icon: "me_setting", name: "设置")
            Line()
          }
        }.background(Color("cell"))
      }
    }.onAppear {
      self.root.tabNavigationHidden = true
    }
      .background(Color("light_gray"))
  }
}

struct MeView_Previews: PreviewProvider {
  static var previews: some View {
    MeView()
      .environmentObject(RootViewModel())
  }
}

private struct Header: View {

  let member: Member

  var body: some View {
    VStack {
      HStack {
        Spacer()
        Image(systemName: "camera.fill")
          .renderingMode(.original)
          .padding(.trailing, 6)
      }
        .frame(height: 44)

      HStack(spacing: 32) {
        Image(member.icon)
          .renderingMode(.original)
          .resizable()
          .frame(width: 62, height: 62)
          .cornerRadius(6)

        VStack(alignment: .leading, spacing: 8) {
          Text(member.name)
            .foregroundColor(.black)
            .font(.system(size: 22, weight: .medium))
          HStack {
            Text("微信号：\(member.identifier ?? "")")
              .foregroundColor(.secondary)
              .font(.system(size: 14, weight: .regular))
            Spacer()

            Image("me_qrcode")
              .renderingMode(.original)
            Image("cell_detail_indicator")
              .renderingMode(.original)
          }
        }
      }
    }.padding(EdgeInsets(top: 0, leading: 12, bottom: 12, trailing: 12))
  }
}


