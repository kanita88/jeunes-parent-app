//
//  PourMoiView.swift
//  jeunesParents
//
//  Created by Apprenant 125 on 18/10/2024.
//

import SwiftUI

struct PourMoiView: View {
   @State private var searchText = ""

   var body: some View {
      VStack(spacing: 20) {
         Text("Aujourd'hui, vous êtes de bonne humeur !")
            .font(.headline)
            .padding(.top, 40)

            //TODO: revoir la searchBar
         SearchBar(text: $searchText)

         ScrollView {
            VStack(spacing: 25) {

               VStack(alignment: .leading) {
                  Text("moment de détente")
                     .font(.system(size: 18, weight: .medium))

                  DetenteImage()
               }

               VStack(alignment: .leading) {
                  Text("tuto et articles")
                     .font(.system(size: 18, weight: .medium))

                  TutorialGrid()
               }

               VStack(alignment: .leading) {
                  Text("communauté et conseil du jour")
                     .font(.system(size: 18, weight: .medium))

                  CommunauteGroupe()
               }
            }
            .padding(.horizontal)
         }
      }
   }
}

struct SearchBar: View {
   @Binding var text: String

   var body: some View {
      HStack {
         TextField("", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())

         Image(systemName: "magnifyingglass")
            .foregroundColor(.gray)
      }
      .padding(.horizontal)
   }
}

struct DetenteImage: View {
   var body: some View {
      ZStack(alignment: .bottomLeading) {
         Image("jogging")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 15))

         Text("prendre du temps pour soi")
            .foregroundColor(.white)
            .padding(12)
            .font(.system(size: 16, weight: .medium))
      }
   }
}

struct TutorialGrid: View {
   var body: some View {
      HStack(spacing: 12) {
         TutorialCard(image: "allaitement", title: "l'allaitement")
         TutorialCard(image: "habiller", title: "l'élever seule")
         TutorialCard(image: "dort", title: "Premiers gestes")
      }
   }
}

struct TutorialCard: View {
   let image: String
   let title: String

   var body: some View {
      ZStack(alignment: .bottomLeading) {
         Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 110, height: 110)
            .clipShape(RoundedRectangle(cornerRadius: 12))

         Text(title)
            .foregroundColor(.white)
            .font(.system(size: 12, weight: .medium))
            .padding(8)
      }
   }
}

struct CommunauteGroupe: View {
   var body: some View {
      HStack(spacing: 12) {
         CommunauteImg(image: "travail", title: "reprendre le travail")
         CommunauteImg(image: "ensemble", title: "la communauté")
      }
   }
}

struct CommunauteImg: View {
   let image: String
   let title: String

   var body: some View {
      ZStack(alignment: .bottomLeading) {
         Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 170, height: 170)
            .clipShape(RoundedRectangle(cornerRadius: 12))

         Text(title)
            .foregroundColor(.white)
            .font(.system(size: 14, weight: .medium))
            .padding(8)
      }
   }
}

#Preview {
   PourMoiView()
}

