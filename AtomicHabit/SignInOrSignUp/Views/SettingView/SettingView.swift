//
//  SettingView.swift
//  AtomicHabit
//
//  Created by Hung-Chun Tsai on 2021-03-15.
//  Copyright © 2021 CodeMonk. All rights reserved.
//

import SwiftUI

struct SettingView: View {
  // MARK: - PROPERTIES
  
  @Environment(\.presentationMode) var presentationMode
  @AppStorage("isOnboarding") var isOnboarding: Bool = false
  
  // MARK: - BODY

  var body: some View {
    NavigationView{
        VStack {
            TopBarView()
            ScrollView{
                VStack(spacing: 20) {
                  // MARK: - SECTION 1
                  
                  GroupBox(
                    label:
                      SettingLabelView(labelText: "Atomic Habit", labelImage: "info.circle")
                  ) {
                    Divider().padding(.vertical, 4)
                    
                    HStack(alignment: .center, spacing: 10) {
                      Image("Icon-51")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .cornerRadius(9)
                      
                      Text("Atomic Habit is an application that will help you to develop the good habit effortless.")
                        .font(.footnote)
                    }
                  }
                  
                  // MARK: - SECTION 2
                  
                  GroupBox(
                    label: SettingLabelView(labelText: "About Us", labelImage: "paintbrush")
                  ) {
                    Divider().padding(.vertical, 4)
                    
                    Text("CodeMonk is a group form by different country who have a passion about develop website and the iOS application. We aim at provide better user experience and try to let user focus on their own task rather than design an additive application.")
                      .padding(.vertical, 8)
                      .frame(minHeight: 60)
                      .layoutPriority(1)
                      .font(.footnote)
                      .multilineTextAlignment(.leading)
                    

                  }
                  
                  // MARK: - SECTION 3
                  
                  GroupBox(
                    label:
                    SettingLabelView(labelText: "Application", labelImage: "apps.iphone")
                  ) {
                    SettingsRowView(name: "Developer", content: "CodeMonk")
                    SettingsRowView(name: "Compatibility", content: "iOS 14")
                    SettingsRowView(name: "Previous Works", linkLabel: "Youtube", linkDestination: "youtube.com/playlist?list=PL4scIpuYXRRdHRXPCOhnTATJoIKgy7M9b")
                    SettingsRowView(name: "Contact Info - Carter", linkLabel: "@Hung-Chun", linkDestination: "www.linkedin.com/in/hungchun-tsai-372584175/")
                    SettingsRowView(name: "SwiftUI", content: "2.0")
                    SettingsRowView(name: "Version", content: "1.0.0")
                  }
                  
                } //: VSTACK
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
    
    
    
        
  }
}


 // MARK: - SettingsRowView
struct SettingsRowView: View {
  // MARK: - PROPERTIES
  
  var name: String
  var content: String? = nil
  var linkLabel: String? = nil
  var linkDestination: String? = nil

  // MARK: - BODY

  var body: some View {
    VStack {
      Divider().padding(.vertical, 4)
      
      HStack {
        Text(name).foregroundColor(Color.gray)
        Spacer()
        if (content != nil) {
          Text(content!)
        } else if (linkLabel != nil && linkDestination != nil) {
          Link(linkLabel!, destination: URL(string: "https://\(linkDestination!)")!)
          Image(systemName: "arrow.up.right.square").foregroundColor(.pink)
        }
        else {
          EmptyView()
        }
      }
    }
  }
}



struct SettingLabelView: View {
  // MARK: - PROPERTIES
  
  var labelText: String
  var labelImage: String?

  // MARK: - BODY

  var body: some View {
    HStack {
      Text(labelText.uppercased()).fontWeight(.bold)
      Spacer()
        Image(systemName: labelImage ?? "circle")
    }
  }
}

// MARK: - PREVIEW

struct SettingView_Previews: PreviewProvider {
  static var previews: some View {
    SettingView()
      .preferredColorScheme(.dark)
      .previewDevice("iPhone 11 Pro")
  }
}
