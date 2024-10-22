//
//  PourMoiView.swift
//  jeunesParents
//
//  Created by Apprenant 125 on 18/10/2024.
//

//import SwiftUI
//
//struct PourMoiView: View {
//   @State var searchText: String = ""
//
//   var body: some View {
//      NavigationStack {
//         ScrollView {
//            VStack(alignment: .leading, spacing: 20) {
//               NavigationStack {
//                  List {
//
//                  }
//                  .navigationBarTitle("Aujourd'hui, vous êtes de bonne humeur !")
//                  .navigationBarTitleDisplayMode(.inline) // Affiche le titre dans la barre de navigation
//                  .searchable(text: $searchText, prompt: "Rechercher un article...")
//               }
//
//            }
//         }
//      }
//   }
//}
//
//
//
//#Preview {
//   PourMoiView()
//
//}

struct PourMoiView: View {
   var body: some View {
      NavigationView {
         ScrollView {
            VStack(alignment: .leading, spacing: 20) {
               Text("Aujourd'hui, vous êtes de bonne humeur !")
                  .font(.headline)

               SearchBar()

            RelaxationMomentView()

               TutorialsAndArticlesView()

               CommunityAndAdviceView()
            }
            .pading()
         }
         .navigationBarHidden(true)
      }
   }
}

struct SearchBar: View {

}