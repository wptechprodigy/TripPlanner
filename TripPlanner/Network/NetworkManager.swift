//
//  NetworkManager.swift
//  TripPlanner
//
//  Created by waheedCodes on 21/02/2025.
//

import Foundation
import Alamofire

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

struct ApiResponse: Codable {
    let status: String
    let message: String
    let data: [FoodItem]
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://assessment.vgtechdemo.com/api/foods"
    
    func fetchFoods(completion: @escaping (Result<[FoodItem], Error>) -> Void) {
        AF.request(baseURL).responseDecodable(of: ApiResponse.self) { response in
            switch response.result {
            case .success(let apiResponse):
                completion(.success(apiResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
