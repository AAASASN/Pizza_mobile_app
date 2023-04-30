//
//  MenuTableViewCell.swift
//  P_App
//
//  Created by Александр Мараенко on 06.04.2023.
//

import UIKit

protocol MenuTableViewCellInputProtocol: AnyObject {
    
    func inputImage(image: UIImage)
    func inputNameText(name: String)
    func inputDescriptionText(description: String)
    func inputPriceFromButtonText(PriceFromButtonText: String)
    func startActivityIndicator()
    func stopActivityIndicator()
    
}

class MenuTableViewCell: UITableViewCell {
    
    var mvpPresenter: MenuTableViewCellPresenterProtocol?
    
    var image: UIImageView!
    var activityIndicator: UIActivityIndicatorView!
    var nameLabel: UILabel!
    var descriptionLabel: UILabel!
    var priceFromButton: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createCellElements()
        addAllSubviews()
        setConstraints()
        
        self.selectionStyle = .none
        backgroundColor = .white

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCellElements() {
                
        image = {
            let image = UIImageView(frame: .zero)
            image.contentMode = .scaleAspectFill
            return image
        }()
        
        activityIndicator = {
            let activityIndicator = UIActivityIndicatorView()
            return activityIndicator
        }()
        
        nameLabel = {
            let nameLabel = UILabel(frame: .zero)
            nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
            return nameLabel
        }()
        
        descriptionLabel = {
            let descriptionLabel = UILabel(frame: .zero)
            descriptionLabel.font = UIFont.systemFont(ofSize: 13)
            descriptionLabel.textColor = .systemGray2
            descriptionLabel.numberOfLines = 0
            return descriptionLabel
        }()
        
        priceFromButton = {
            
            let priceFromButton = UIButton(frame: .zero)
            priceFromButton.layer.borderWidth = 1
            priceFromButton.layer.borderColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 0.60).cgColor
            priceFromButton.layer.cornerRadius = 7
            priceFromButton.setTitleColor(.red, for: .normal)
            
            let action = UIAction { _ in
                print("")
                print("DEBUG MenuTableViewCell")
                print("priceFromButton pressed")
            }
            
            priceFromButton.addAction(action, for: .touchDown)
            
            return priceFromButton
            
        }()
    }
    
    
    func addAllSubviews() {
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceFromButton)
        image.addSubview(activityIndicator)
    }
    
    
    func setConstraints() {
        
        image.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceFromButton.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
                                     image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                                     image.widthAnchor.constraint(equalToConstant: 132),
                                     image.heightAnchor.constraint(equalToConstant: 132)
                                     ])
        
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                                     nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 32),
                                     nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
                                     nameLabel.heightAnchor.constraint(equalToConstant: 20)
                                     ])
      
        NSLayoutConstraint.activate([descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
                                     descriptionLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 32),
                                     descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
                                     descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -70)
                                    ])
        
        NSLayoutConstraint.activate([priceFromButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -56),
                                     priceFromButton.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -113),
                                     priceFromButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
                                     priceFromButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
                                    ])
        
        NSLayoutConstraint.activate([activityIndicator.topAnchor.constraint(equalTo: image.topAnchor, constant: 20),
                                     activityIndicator.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 20),
                                     activityIndicator.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -20),
                                     activityIndicator.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -20)
                                    ])

    }

}

extension MenuTableViewCell: MenuTableViewCellInputProtocol {
    
    func inputImage(image: UIImage) {
        self.image.image = image
    }
    
    func inputNameText(name: String) {
        nameLabel.text = name
    }
    
    func inputDescriptionText(description: String) {
        descriptionLabel.text = description
    }
    
    func inputPriceFromButtonText(PriceFromButtonText: String) {
        let str = "от \(PriceFromButtonText) р"
        priceFromButton.setTitle(str, for: .normal)
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

}
