//
//  AdviceView.swift
//  jeunesParents
//
//  Created by Klesya on 18/10/2024.
//

import SwiftUI

struct AdviceView: View {
    @StateObject private var forumViewModel = ForumViewModel()
    @State var searchBar : String = ""
    var jpBlue = Color(red: 0.29, green: 0.47, blue: 0.59)
    private var categories = ["Parent", "Enfant", "Grossesse", "Post-Partum", "Pro"]
    var body: some View {
        NavigationStack {
            ScrollView {
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
                    .padding(.top, 3.0)
                    
                    Text("Forum")
                        .padding(.top, -1.0)
                        .foregroundStyle(jpBlue)
                        .bold()
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading, 16.0)
                        .font(.title)
                    
                    ScrollView {
                        ForEach(forumViewModel.forums) { forum in
                            HStack {
                                    VStack {
                                        Text(forum.title)
                                            .lineLimit(1)
                                            .fontWeight(.semibold)
                                            .font(.system(size: 16))
                                            .frame(maxWidth: .infinity,alignment: .leading)
                                        Text(forum.description)
                                            .lineLimit(2)
                                            .foregroundStyle(.gray)
                                            .font(.system(size: 12))
                                            .frame(maxWidth: .infinity,alignment: .leading)
                                        
                                        HStack {
                                            Text("00/00/0000")
                                                .foregroundStyle(.gray)
                                                .font(.system(size: 10))
                                            
                                            HStack(spacing:0) {
                                                Image(systemName: "message.fill")
                                                Text("\(forum.comment.count)")
                                            }
                                            .foregroundStyle(.gray)
                                            .font(.system(size: 10))
                                            
                                            Rectangle()
                                                .foregroundStyle(.gray)
                                                .frame(width: 40.0, height: 13.0)
                                                .cornerRadius(20)
                                        }
                                        .padding(.top, -3.0)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                    }
                                    
                                    VStack {
                                        Image(systemName: forum.resolu ? "checkmark.bubble.fill" : "bubble")
                                            .font(.system(size: 25))
                                        Text(forum.resolu ? " Résolu " : "Non\nrésolu")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: 15))
                                    }
                                    .foregroundColor(jpBlue)
                                }
                                .padding(.horizontal, 47.0)
                                .padding(.vertical, 16.0)
                                .background() {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 351)
                                        .background(Color(red: 0.94, green: 0.95, blue: 0.98))
                                        .cornerRadius(24)
                                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                            }
                        }
                    }
                    .padding(.top, -12.0)
                    .frame(height: 300.0)
                    
                    
                    Text("Articles")
                        .padding(.top, 8)
                        .padding(.bottom, -5.0)
                        .foregroundStyle(jpBlue)
                        .bold()
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading, 16.0)
                        .font(.title)
                    
                    HStack(spacing: 10) {
                        Rectangle()
                            .frame(width: 140, height: 140)
                            .cornerRadius(25)
                            .foregroundStyle(.black)
                            .background() {
                                ZStack {
                                    Rectangle()
                                        .frame(width: 140, height: 83)
                                        .cornerRadius(25)
                                        .foregroundStyle(Color(red: 0.94, green: 0.95, blue: 0.98))
                                        .padding(.top, 130.0)
                                    Text("Title")
                                        .multilineTextAlignment(.center)
                                        .font(.system(size: 11))
                                        .padding(.top, 160.0)
                                }
                            }
                    }
                    
                }
            }
            .navigationTitle("Conseils")
        }
    }
}

#Preview {
    AdviceView()
}
