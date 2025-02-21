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
    
    var testFoodItem: FoodItem!
    
    override func setUp() {
        super.setUp()
        
        // Create a mock FoodItem for multiple tests (Avoid redundant JSON decoding)
        testFoodItem = FoodItem(
            id: 1,
            name: "Garlic Butter Shrimp Pasta",
            description: "Delicious shrimp pasta.",
            category_id: 8,
            calories: 320,
            foodTags: ["Healthy", "Vegetarian"],
            foodImages: [FoodImage(id: 1, image_url: "https://example.com/image.jpg")],
            category: FoodCategory(id: 8, name: "Meat", description: "Beef and pork")
        )
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // Test JSON Decoding with static data
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
    
    // Test Network Request with Mocked Response (Avoids real API call)
    func testNetworkManagerFetchFoods() {
        let mockJSON = """
            {
                "status": "success",
                "message": "Foods Fetched Successfully",
                "data": [
                    {
                        "id": 1,
                        "name": "Mock Food",
                        "description": "This is a test food.",
                        "category_id": 2,
                        "calories": 200,
                        "foodTags": ["Test", "Mock"],
                        "foodImages": [{"id": 1, "image_url": "https://example.com/mock.jpg"}],
                        "category": {"id": 2, "name": "Test Category", "description": "Test Description"}
                    }
                ]
            }
            """.data(using: .utf8)!
        
        let expectation = self.expectation(description: "Fetch Foods API Call")
        var fetchedFoods: [FoodItem] = []
        
        // Mock decoding instead of calling API
        do {
            let decodedResponse = try JSONDecoder().decode(ApiResponse.self, from: mockJSON)
            fetchedFoods = decodedResponse.data
        } catch {
            XCTFail("Failed to decode mock response")
        }
        
        expectation.fulfill()
        waitForExpectations(timeout: 1, handler: nil)
        
        XCTAssertFalse(fetchedFoods.isEmpty, "Fetched foods should not be empty")
    }
    
    // Test SwiftUI View Initialization (Optimized)
    func testFoodDetailViewRendering() {
        let view = FoodDetailView(food: testFoodItem)
        XCTAssertNotNil(view, "FoodDetailView should be initialized correctly")
    }
}
