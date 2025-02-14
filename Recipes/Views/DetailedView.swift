//
//  DetailedView.swift
//  Recipes
//
//  Created by Olimpia Compean on 2/13/25.
//

import SwiftUI

struct DetailedView: View {
    let recipeWithImage: RecipeWithImage
    
    var body: some View {
        VStack(spacing: Double.mediumRadius) {
            VStack(spacing: Double.smallSpacing) {
                Text(recipeWithImage.recipe.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(recipeWithImage.recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                if let videoUrl = recipeWithImage.recipe.youtubeURL.flatMap(URL.init) {
                    Link(destination: videoUrl) {
                        Image(systemName: "play.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: Double.standardDimension, height: Double.standardDimension)
                            .foregroundColor(.gray)
                            .opacity(Double.mediumOpacity)
                            .scaledToFit()
                    }
                }
                
                if let sourceUrl = recipeWithImage.recipe.sourceURL.flatMap(URL.init) {
                    Link(String.recipeLinkText, destination: sourceUrl)
                        .font(.body)
                        .foregroundColor(.blue)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            if let image = recipeWithImage.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: Double.largeDimension, height: Double.largeDimension)
                    .clipShape(RoundedRectangle(cornerRadius: Double.largeRadius))
                    .shadow(radius: Double.smallRadius)
            }
            Spacer()
        }
        .padding()
    }
}
