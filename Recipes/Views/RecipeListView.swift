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
                    ProgressView(String.loadingText)
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
            .navigationTitle(String.titleText)
            .navigationDestination(item: $selectedRecipe) { recipe in
                DetailedView(recipeWithImage: recipe)
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
                    .frame(width: Double.standardDimension, height: Double.standardDimension)
                    .clipShape(RoundedRectangle(cornerRadius: Double.mediumRadius))
                    .clipped()
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: Double.mediumRadius)
                        .fill(Color.gray.opacity(Double.lightOpacity))
                        .frame(width: Double.standardDimension, height: Double.standardDimension)
                    ProgressView()
                }
            }
            
            VStack(alignment: .leading) {
                Text(recipeWithImage.recipe.name)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(recipeWithImage.recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, Double.smallPadding)
        }
    }
}
