//
//  ContentView.swift
//  SwiftUI+PhoneNumberKit
//
//  Created by Tema.Tian on 2020/6/8.
//  Copyright © 2020 Tema.Tian. All rights reserved.
//


import SwiftUI
import PhoneNumberKit

struct ContentView: View {
  @State private var phoneNumber = ""

  var body: some View {
    VStack {
      VStack {
        HStack {
          Text("+1")
          PhoneTextField()
        }
        Separator()
      }.frame(height: 44)
       .padding(.top, 60)
      Spacer()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct PhoneTextField: UIViewRepresentable {

  func makeUIView(context: Context) -> MyGBTextField {
    let phoneNumberKit = PhoneNumberKit()
    let textField = MyGBTextField(withPhoneNumberKit: phoneNumberKit)
    textField.withDefaultPickerUI = false
    textField.withPrefix = false
    textField.withFlag = false
    textField.withExamplePlaceholder = false
    textField.placeholder = "Phone"
    textField.maxDigits = 10
    return textField
  }

  func updateUIView(_ view: MyGBTextField, context: Context) {

  }
}


class MyGBTextField: PhoneNumberTextField {

  override var defaultRegion: String {
    get {
      return "US"
    }
    set { }
  }
}

struct Separator: View {
  let color: Color

  var body: some View {
    Divider()
      .overlay(color)
      .padding(.zero)
  }

  init(color: Color = Color("separator")) {
    self.color = color
  }
}



