//
//  FoodCardView.swift
//  TripPlanner
//
//  Created by waheedCodes on 19/02/2025.
//

import UIKit
import SDWebImage

class FoodCardView: UIView {
    
    private let foodImageView = UIImageView()
    private let titleLabel = UILabel()
    private let calorieLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let tagsStackView = UIStackView()
    private let favoriteButton = UIButton(type: .system)
    
    init(foodImageUrl: String?, title: String, calories: String, description: String, tags: [String]) {
        super.init(frame: .zero)
        setupUI()
        configure(foodImageUrl: foodImageUrl, title: title, calories: calories, description: description, tags: tags)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyTopCornerRadius() {
        let path = UIBezierPath(
            roundedRect: foodImageView.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 12, height: 12)
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        foodImageView.layer.mask = maskLayer
    }
    
    private func setupUI() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        translatesAutoresizingMaskIntoConstraints = false
        
        // Food Image
        foodImageView.contentMode = .scaleAspectFill
        foodImageView.clipsToBounds = true
        addSubview(foodImageView)
        
        // Title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .darkText
        addSubview(titleLabel)
        
        // Calories
        calorieLabel.font = UIFont.systemFont(ofSize: 14)
        calorieLabel.textColor = .gray
        addSubview(calorieLabel)
        
        // Description
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 2
        addSubview(descriptionLabel)
        
        // Tags Stack View
        tagsStackView.axis = .horizontal
        tagsStackView.spacing = 5
        addSubview(tagsStackView)
        
        // Favorite Button
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = .gray
        addSubview(favoriteButton)
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyTopCornerRadius()
    }
    
    private func setupConstraints() {
        foodImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        calorieLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        tagsStackView.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Food Image should stretch across the full width
            foodImageView.topAnchor.constraint(equalTo: topAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodImageView.heightAnchor.constraint(equalToConstant: 150),

            // Title
            titleLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: 10),

            // Favorite Button
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            favoriteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

            // Calories Label
            calorieLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            calorieLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),

            // Description
            descriptionLabel.topAnchor.constraint(equalTo: calorieLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            // Tags Stack View
            tagsStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            tagsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tagsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func configure(foodImageUrl: String?, title: String, calories: String, description: String, tags: [String]) {
        if let urlString = foodImageUrl, let url = URL(string: urlString) {
            foodImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        } else {
            foodImageView.image = UIImage(systemName: "photo") // Placeholder image
        }
        
        titleLabel.text = title
        calorieLabel.text = "🔥 \(calories) Calories"
        descriptionLabel.text = description

        // Clear old tags
        tagsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for tag in tags {
            let label = createTagLabel(text: tag, color: .orange)
            label.translatesAutoresizingMaskIntoConstraints = false
            tagsStackView.addArrangedSubview(label)
        }
    }
    
    private func createTagLabel(text: String, color: UIColor, opacity: CGFloat = 0.3) -> UILabel {
        let label = PaddedLabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .darkText
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.setBackgroundColor(color, opacity: opacity)
        return label
    }
}
