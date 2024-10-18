//
//  AdviceView.swift
//  jeunesParents
//
//  Created by Klesya on 18/10/2024.
//

import SwiftUI

struct AdviceView: View {
    @State var searchBar : String = ""
    var jpBlue = Color(red: 0.29, green: 0.47, blue: 0.59)
    private var categories = ["Parent", "Enfant", "Grossesse", "Post-Partum", "Pro"]
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField(text: $searchBar, label: {
                        Text("Rechercher un mot clef")
                    })
                }
                .padding()
                .frame(width: 289, height: 32)
                .background(Color(red: 0.94, green: 0.95, blue: 0.98).opacity(0.8))
                .cornerRadius(15)
                
                HStack {
                    ForEach(categories, id: \.self) { category in
                        ZStack {
                            Circle()
                                .stroke(jpBlue, lineWidth: 1.5)
                                .foregroundColor(.clear)
                                .frame(width: 69.0, height: 69.0)
                            Text(category)
                                .font(.system(size: 10))
                                .foregroundColor(jpBlue)
                        }
                    }
                }
                .padding()
                
                Text("Forum")
                    .foregroundStyle(jpBlue)
                    .bold()
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.leading, 16.0)
                    .font(.title)
                
                    HStack {
                        VStack {
                            Text("Title")
                                .frame(maxWidth: .infinity,alignment: .leading)
                            Text("Description")
                                .frame(maxWidth: .infinity,alignment: .leading)
                            
                            HStack {
                                Text("00/00/0000")
                                
                                HStack(spacing:0) {
                                    Image(systemName: "message.fill")
                                    Text("3")
                                }
                                
                                Rectangle()
                                    .frame(width: 44, height: 15)
                                    .cornerRadius(20)
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                        }
                        
                        VStack {
                            Image(systemName: "checkmark.bubble.fill")
                                .font(.system(size: 25))
                            Text("Résolu")
                        }
                        .foregroundColor(jpBlue)
                    }
                    .background() {
                        Rectangle()
                          .foregroundColor(.clear)
                          .frame(width: 351, height: 80)
                          .background(.white)
                          .cornerRadius(24)
                          .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                
                Text("Articles")
                    .foregroundStyle(jpBlue)
                    .bold()
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.leading, 16.0)
                    .font(.title)
                
                
                
            }
            .navigationTitle("Conseils")
        }
    }
}

#Preview {
    AdviceView()
}
