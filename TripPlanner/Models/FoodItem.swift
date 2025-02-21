//
//  FoodItem.swift
//  TripPlanner
//
//  Created by waheedCodes on 21/02/2025.
//

import Foundation

struct FoodImage: Codable {
    let id: Int
    let image_url: String
}

struct FoodCategory: Codable {
    let id: Int
    let name: String
    let description: String
}

struct FoodItem: Codable {
    let id: Int
    let name: String
    let description: String
    let category_id: Int
    let calories: Int
    let foodTags: [String]
    let foodImages: [FoodImage]
    let category: FoodCategory
    
    var firstImageUrl: String {
        return foodImages.first?.image_url ?? ""
    }
}
