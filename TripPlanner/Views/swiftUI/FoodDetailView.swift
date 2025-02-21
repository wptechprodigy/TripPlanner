//
//  FoodDetailView.swift
//  TripPlanner
//
//  Created by waheedCodes on 20/02/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct FoodDetailView: View {
    let food: FoodItem
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Top Buttons
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                    Spacer()
                    Button(action: { /* Handle favorite action */ }) {
                        Image(systemName: "heart")
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                    Button(action: { /* Handle edit action */ }) {
                        Image(systemName: "square.and.pencil")
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                
                // Food Image
                WebImage(url: URL(string: food.firstImageUrl), options: [.decodeFirstFrameOnly, .avoidAutoSetImage])
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(maxWidth: CGFloat.infinity)
                    .overlay(
                        Group {
                            if food.firstImageUrl.isEmpty {
                                Image("lemon_herb_chicken_fettuccine")
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    )
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
                // Title and Tags
                Text(food.name)
                    .font(.title2)
                    .bold()
                    .foregroundStyle(Color.black)
                    .padding(.horizontal)
                
                HStack {
                    ForEach(food.foodTags, id: \..self) { tag in
                        Text(tag)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.orange.opacity(0.3))
                            .foregroundStyle(Color.black)
                            .clipShape(Capsule())
                    }
                }
                .padding(.horizontal)
                
                // Description
                Text(food.description)
                    .font(.subheadline)
                    .foregroundStyle(Color.black)
                    .padding()
                
                // Nutrition Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nutrition")
                        .font(.subheadline)
                        .foregroundStyle(Color.black)
                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.red)
                        Text("\(food.calories) Calories")
                            .foregroundStyle(Color.black)
                    }
                    .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .padding(.horizontal, 16)
                
                // Notes Section
                VStack(alignment: .leading) {
                    Text("Notes")
                        .foregroundStyle(Color.black)
                    Button(action: { /* Handle add notes */ }) {
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text("Add notes")
                        }
                    }
                }
                .font(.subheadline)
                .padding()
                
                Spacer(minLength: 80)
                
                // Remove button
                Button(action: { /* Handle remove action */ }) {
                    Text("Remove from collection")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
        .scrollIndicators(.never)
        .navigationBarHidden(true)
    }
}

// Preview
struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(food: FoodItem(id: 1, name: "Garlic Butter Shrimp Pasta", description: "Creamy hummus spread on whole grain toast topped with sliced cucumbers and radishes...", category_id: 8, calories: 320, foodTags: ["healthy", "vegetarian"], foodImages: [FoodImage(id: 1, image_url: "https://example.com/image.jpg")], category: FoodCategory(id: 8, name: "Meat", description: "Beef, pork, and other meats")))
    }
}
