//
//  HomeHeaderView.swift
//  TripPlanner
//
//  Created by waheedCodes on 20/02/2025.
//

import UIKit

class HomeHeaderView: UIView {
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Hey there, Lucy!"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Are you ready to create a tasty dish today?"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bellIcon: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let searchBar: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search foods..."
        textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        textField.layer.cornerRadius = 10
        textField.setLeftPaddingPoints(10)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 10)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "All"
        return label
    }()
    
    private let categories = ["All", "Morning Food", "Sunrise Meal", "Dawn Delicacies"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        addSubview(profileImageView)
        addSubview(greetingLabel)
        addSubview(subTextLabel)
        addSubview(bellIcon)
        addSubview(searchBar)
        addSubview(categoryCollectionView)

        NSLayoutConstraint.activate([
            // Profile Image
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: -10),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),

            // Bell Icon (Right Side)
            bellIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            bellIcon.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            
            // Greeting Label
            greetingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            greetingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            greetingLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            
            // Subtext Label
            subTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            subTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            subTextLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 2),
            
            // Search Bar
            searchBar.topAnchor.constraint(equalTo: subTextLabel.bottomAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant:10),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            // Category Collection View
            categoryCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 15),
            categoryCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            categoryCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 60),

            bottomAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor)
        ])
    }
    
    private func setupCollectionView() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
    }
    
    func updateCategoryTitle(_ title: String) {
        categoryTitleLabel.text = title
    }
}

// MARK: - Collection View Delegate & Data Source
extension HomeHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.configure(with: categories[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.item]
        updateCategoryTitle(selectedCategory)
    }
}

// MARK: - Category Cell
class CategoryCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            updateSelectionState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .center
        
        contentView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        contentView.layer.cornerRadius = 12
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    private func updateSelectionState() {
        if isSelected {
            contentView.backgroundColor = .systemBlue
            titleLabel.textColor = .white
        } else {
            contentView.backgroundColor = UIColor(white: 0.9, alpha: 1)
            titleLabel.textColor = .gray
        }
    }
}
