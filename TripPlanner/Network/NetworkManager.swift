//
//  NetworkManager.swift
//  TripPlanner
//
//  Created by waheedCodes on 21/02/2025.
//

import Foundation
import Alamofire

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
