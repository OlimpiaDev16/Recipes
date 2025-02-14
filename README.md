## 🍽️ Recipe Finder
#### Recipe Finder is a SwiftUI-based iOS app that allows users to browse, search, and view details of various recipes. The app fetches recipe data from a remote JSON API and provides an intuitive interface for discovering delicious meals.

## 📱 Features
- 📋 Filter by Cuisine: (** not ready at this commit)
- ➡️ Detailed Recipe View: Access link to the full recipes and other related media.
- 🖼️ Image Caching: Efficiently load and display recipe images.

## 🛠️ Technologies Used
- Swift & SwiftUI - Modern declarative UI framework
- URLSession - Fetch recipes from the API
- Image Caching - Efficient image loading

## 🌐 API
- The app fetches recipe data from the following endpoint:
[🔗 Recipe JSON API](https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json)

### Each recipe entry includes:
```
{
  "name": "Spaghetti Carbonara",
  "cuisine": "Italian",
  "image": "https://example.com/spaghetti.jpg",
  "youtubeURL": "https://www.youtube.com/watch?v=example",
  "sourceURL": "https://example.com/full-recipe"
}
```

## 🚀 Getting Started
### Prerequisites:
- Xcode 15+
- iOS 17+ simulator or device

## Installation
- 1. Close the repository 
```
git clone -link to the repo-
cd Recipes
```
- 2. Open in Xcode
``` open Recipes.xcodeproj
```
- 3. Run the app on a simulator or physical device.

## 🏗️ Architecture 
- MVVM (Model-View-ViewModel): Separates UI logic from data fetching and state management.
- Dependency Injection: Makes networking and data models testable.

## 🎥 Summary
### 📸 Screenshots & Demo Video
#### HERE: Include screenshots or a video showcasing the app's features. (Add links or embed images)

## 🎯 Focus Areas
### I prioritized the following areas:

- User Experience (UX): Ensuring smooth navigation and a clean UI.
- Performance: Optimized image loading and API calls for a responsive app.
- Scalability: Using MVVM to keep the codebase modular and maintainable.
- SwiftUI Best Practices: Leveraging SwiftUI features like @StateObject and ObservableObject.
- These areas were chosen to ensure a balance between usability, performance, and maintainability.

## ⏳ Time Spent
### I spent approximately 20 hours working on this project. My time was allocated as follows:

- Project Setup & API Integration and Testing: 6 hours
- UI Development: 3 hours 
- State Management & Logic: 4 hours
- Testing & Debugging: 3 hours
- Polishing & Optimization: 4 hours

## ⚖️ Trade-offs and Decisions
### Some trade-offs I made during development:

- AsyncImage vs Custom Image Caching: Used AsyncImage for simplicity but could implement custom caching for better performance.
- Minimalistic UI vs Feature-Rich Design: Focused on core functionality instead of adding extra animations or complex layouts.
- Limited Offline Support: Chose to prioritize real-time data fetching over full offline caching due to time constraints.

## 🛠️ Weakest Part of the Project
### The weakest part of the project is limited offline support, error handling, or UI polish. If I had more time, I would improve better caching, more robust error handling, UI enhancements.
### In addition to enhancements, I would also add user friendly features: 
- 🔍 Search Recipes: Find recipes by name.
- 🌍 Filter by Cuisine: Browse recipes based on cuisine type.
- 🎥 YouTube Integration: Watch cooking tutorial videos directly from the app.




