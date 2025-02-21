//
//  HomeViewController.swift
//  TripPlanner
//
//  Created by waheedCodes on 19/02/2025.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let headerView = HomeHeaderView()
    private var foods: [FoodItem] = []
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
    }
    
    private func setupTableView() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FoodCardCell.self, forCellReuseIdentifier: "FoodCardCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchFoods { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedFoods):
                    self?.foods = fetchedFoods
                    self?.tableView.reloadData()
                case .failure(let error):
                    print("Failed to fetch foods: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCardCell", for: indexPath) as? FoodCardCell else {
            return UITableViewCell()
        }
        cell.configure(with: foods[indexPath.row])
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFood = foods[indexPath.row]
        let detailView = FoodDetailView(food: selectedFood)
        let hostingController = UIHostingController(rootView: detailView)
        
        hostingController.view.backgroundColor = .white
        
        navigationController?.pushViewController(hostingController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class FoodCardCell: UITableViewCell {
    private let foodCardView = FoodCardView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(foodCardView)
        foodCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            foodCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            foodCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            foodCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            foodCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    func configure(with food: FoodItem) {
        foodCardView.configure(foodImageUrl: food.firstImageUrl,
                               title: food.name,
                               calories: "\(food.calories)",
                               description: food.description,
                               tags: food.foodTags)
    }
}
