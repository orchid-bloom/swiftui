//
//  DiscoverView.swift
//  WeChat
//
//  Created by Tema.Tian on 2020/5/19.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//

import SwiftUI

struct DiscoverView: View {

  @EnvironmentObject var root: RootViewModel

  var body: some View {
    ScrollView {
      VStack(spacing: 0) {

        Group {
          NavigationLink(destination: MomentView()) {
            Cell(icon: "discover_moment", name: "朋友圈")
          }
          Line()
        }

        Group {
          Cell(icon: "discover_see", name: "视频号")
          Line()
        }

        Group {
          Cell(icon: "discover_qrcode", name: "扫一扫")
          Separator().padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
          Cell(icon: "discover_shake", name: "摇一摇")
          Line()
        }

        Group {
          Cell(icon: "discover_see", name: "看一看")
          Separator().padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
          Cell(icon: "discover_search", name: "搜一搜")
          Line()
        }

        Group {
          Cell(icon: "discover_nearby", name: "附近的人")
          Line()
        }

        Group {
          Cell(icon: "discover_shop", name: "购物")
          Separator().padding(.leading, 52)
          Cell(icon: "discover_game", name: "游戏")
          Line()
        }
        Group {
          Cell(icon: "discover_miniprogram", name: "小程序")
          Line()
        }
      }.background(Color("cell"))
    }.onAppear {
      self.root.tabNavigationHidden = false
    }
      .background(Color("light_gray"))
  }
}

struct DiscoverView_Previews: PreviewProvider {
  static var previews: some View {
    DiscoverView().environmentObject(RootViewModel())
  }
}


struct Cell: View {

  let icon: String
  let name: String

  var body: some View {
    VStack(spacing: 0, content: {
      HStack(spacing: 12) {
        Image(icon)
          .renderingMode(.original)

        Text(name)
          .font(.system(size: 16, weight: .regular))
          .foregroundColor(.primary)

        Spacer()

        Image("cell_detail_indicator")
          .renderingMode(.original)
      }.padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
    })
      .frame(height: 54)
  }
}

struct Line: View {
  var body: some View {
    Rectangle()
      .foregroundColor(Color("light_gray"))
      .frame(height: 8)
  }
}



