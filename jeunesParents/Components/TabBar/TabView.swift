////
////  TabView.swift
////  jeunesParents
////
////  Created by Apprenant 125 on 18/10/2024.
////

import SwiftUI

enum Tab: String {
   case myday = "Ma journée"
   case mychild = "Mon enfant"
   case myself = "Pour Moi"
   case counsels = "Conseils"
}

struct MainTabView: View {
   @State private var selectedTab: Tab = .myday

   static let tertiary = Color("Tertia")

   var body: some View {
      TabView(selection: $selectedTab) {

         Text("Ma journée")
            .tabItem {
               Image(systemName: "sun.max")
                  .renderingMode(.template)
               Text("Ma journée")
            }
            .tag(Tab.myday)


         Text("Mon enfant")
            .tabItem {
               Image(systemName: "teddybear.fill")
                  .renderingMode(.template)
               Text("Mon enfant")
            }
            .tag(Tab.mychild)


         Text("Pour Moi")
            .tabItem {
               Image(systemName: "heart.fill")
                  .renderingMode(.template)
               Text("Pour Moi")
            }
            .tag(Tab.myself)


         Text("Conseils")
            .tabItem {
               Image(systemName: "person.2.wave.2.fill")
                  .renderingMode(.template)
               Text("Conseils")
            }
            .tag(Tab.counsels)
      }
      .accentColor(Color("Tertia"))
   }
}

#Preview {
   MainTabView()
}