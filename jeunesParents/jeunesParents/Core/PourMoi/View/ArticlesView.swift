//
//  ArticlesView.swift
//  jeunesParents
//
//  Created by Apprenant 125 on 23/10/2024.
//

import SwiftUI

struct ArticlesView: View {
   var body: some View {
      VStack(spacing: 0) {
         Image("jogging")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal)
            .padding(.top, 20)

         VStack(alignment: .leading, spacing: 16) {
               // Title
            Text("Le temps pour Soi : Un luxe\nEssentiel pour les Jeunes Parents")
               .font(.system(size: 24, weight: .bold))
               .lineSpacing(4)

            Text("Devenir parent est une expérience incroyable et bouleversante. C'est un moment où l'on découvre un amour inconditionnel pour son enfant, mais c'est aussi une période où les journées semblent s'allonger indéfiniment, rythmées par les couches à changer, les biberons à donner, et les nuits entrecoupées de pleurs. Dans ce tourbillon quotidien, trouver du temps pour soipeut paraître une mission impossible. Pourtant, pour les jeunes parents, se réserver des moments de ressourcement personnel n'est pas un luxe, mais une nécessité.")
               .font(.system(size: 16))
               .lineSpacing(4)
         }
         .padding(.horizontal)
         .padding(.top, 16)

         Spacer()
      }
      .background(Color.white)
   }
}

#Preview {
   ArticlesView()
}
