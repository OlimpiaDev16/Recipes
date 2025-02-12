//
//  ContentView.swift
//  Recipes
//
//  Created by Olimpia Compean on 2/11/25.
//

import AVKit
import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeViewModel(recipeService: .init(networkService: .init()))
    @State private var selectedRecipe: RecipeWithImage?
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Recipes...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.recipesWithImages, id: \.recipe.id) { recipesWithImage in
                        Button {
                            selectedRecipe = recipesWithImage
                        } label: {
                            RecipeRow(recipeWithImage: recipesWithImage)
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .navigationDestination(item: $selectedRecipe) { recipe in
                DestinationView(recipeWithImage: recipe)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchRecipes()
            }
        }
    }
}

#Preview {
    RecipeListView()
}


struct RecipeRow: View {
    let recipeWithImage: RecipeWithImage
    
    var body: some View {
        HStack {
            if let image = recipeWithImage.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                ProgressView()
                    .frame(width: 60, height: 60)
            }
            
            VStack(alignment: .leading) {
                Text(recipeWithImage.recipe.name)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(recipeWithImage.recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct DestinationView: View {
    let recipeWithImage: RecipeWithImage
    
    var body: some View {
        VStack {
            if let image = recipeWithImage.image {
                Text(recipeWithImage.recipe.name)
                    .font(.headline)
                Text(recipeWithImage.recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.black)
                
                if let videoUrl = recipeWithImage.recipe.youtubeURL.flatMap(URL.init) {
                    Link(destination: videoUrl) {
                        ZStack {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Image(systemName: "play.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                                .opacity(0.8)
                                .scaledToFit()
                        }
                        .frame(width: 200, height: 200)
                    }
                }
                
                if let sourceUrl = recipeWithImage.recipe.sourceURL.flatMap(URL.init) {
                    Link("Source", destination: sourceUrl)
                }
                
                Spacer()
            }
            
        }
    }
}
