//
//  TripPlannerTests.swift
//  TripPlannerTests
//
//  Created by waheedCodes on 21/02/2025.
//

import XCTest
import SwiftUI
@testable import TripPlanner

final class TripPlannerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    // ✅ Test JSON Decoding
    func testFoodItemDecoding() throws {
        let json = """
            {
                "id": 1,
                "name": "Garlic Butter Shrimp Pasta",
                "description": "Delicious shrimp pasta.",
                "category_id": 8,
                "calories": 320,
                "foodTags": ["Healthy", "Vegetarian"],
                "foodImages": [{"id": 1, "image_url": "https://example.com/image.jpg"}],
                "category": {"id": 8, "name": "Meat", "description": "Beef and pork"}
            }
            """.data(using: .utf8)!
        
        let decodedItem = try JSONDecoder().decode(FoodItem.self, from: json)
        
        XCTAssertEqual(decodedItem.id, 1)
        XCTAssertEqual(decodedItem.name, "Garlic Butter Shrimp Pasta")
        XCTAssertEqual(decodedItem.calories, 320)
        XCTAssertEqual(decodedItem.foodTags.count, 2)
        XCTAssertEqual(decodedItem.firstImageUrl, "https://example.com/image.jpg")
    }
    
    // ✅ Test Network Request Mocking
    func testNetworkManagerFetchFoods() {
        let expectation = self.expectation(description: "Fetch Foods API Call")
        var fetchedFoods: [FoodItem] = []
        
        NetworkManager.shared.fetchFoods { result in
            switch result {
            case .success(let foods):
                fetchedFoods = foods
            case .failure:
                XCTFail("Failed to fetch foods")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertFalse(fetchedFoods.isEmpty, "Fetched foods should not be empty")
    }
    
    // ✅ Test SwiftUI View Rendering
    func testFoodDetailViewRendering() {
        let food = FoodItem(
            id: 1,
            name: "Garlic Butter Shrimp Pasta",
            description: "Delicious shrimp pasta.",
            category_id: 8,
            calories: 320,
            foodTags: ["Healthy", "Vegetarian"],
            foodImages: [FoodImage(id: 1, image_url: "https://example.com/image.jpg")],
            category: FoodCategory(id: 8, name: "Meat", description: "Beef and pork")
        )
        
        let view = FoodDetailView(food: food)
        let hostingController = UIHostingController(rootView: view)
        
        XCTAssertNotNil(hostingController.view, "FoodDetailView should be initialized correctly")
    }
}
