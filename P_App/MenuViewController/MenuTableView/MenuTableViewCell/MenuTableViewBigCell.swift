//
//  MenuTableViewBigCell.swift
//  P_App
//
//  Created by Александр Мараенко on 11.05.2023.
//


import UIKit
import pop

class MenuTableViewBigCell: UITableViewCell {
    
    var mvpPresenter: MenuTableViewCellPresenterProtocol?
    
    var image: UIImageView!
    var activityIndicator: UIActivityIndicatorView!
    var nameLabel: UILabel!
    var descriptionLabel: UILabel!
    var priceFromButton: UIButton!
    var whiteView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        createCellElements()
        addAllSubviews()
        setConstraints()
        
        self.selectionStyle = .none
        backgroundColor =  UIColor(red: 0.96, green: 0.96, blue: 0.97, alpha: 1.00)  // .systemGray6
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createCellElements() {
        
        whiteView = {
            let whiteView = UIView(frame: .zero)
            whiteView.layer.cornerRadius = 15
            whiteView.backgroundColor = .white

            whiteView.layer.shadowOffset = CGSize(width: 4, height: 4)
            whiteView.layer.shadowRadius = 10
            whiteView.layer.shadowColor = UIColor.gray.cgColor
            whiteView.layer.shadowOpacity = 0.3
            
            return whiteView
        }()
        
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
            nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
            nameLabel.numberOfLines = 0
            
            return nameLabel
        }()
        
        descriptionLabel = {
            let descriptionLabel = UILabel(frame: .zero)
            descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
            descriptionLabel.textColor = .darkGray
            descriptionLabel.numberOfLines = 0
            return descriptionLabel
        }()
        
        priceFromButton = {
            
            let priceFromButton = UIButton(frame: .zero)
            priceFromButton.layer.cornerRadius = 15
            priceFromButton.setTitleColor(UIColor(red: 0.77, green: 0.26, blue: 0.02, alpha: 1.00), for: .normal)
            priceFromButton.backgroundColor = UIColor(red: 1.00, green: 0.93, blue: 0.88, alpha: 1.00)
            priceFromButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
            
            let action = UIAction { _ in
                print("")
                print("DEBUG MenuTableViewBigCell")
                print("priceFromButton pressed")
            }
            
            priceFromButton.addAction(action, for: .touchDown)
            
            return priceFromButton
            
        }()
        
        
    }
    
    
    func addAllSubviews() {
        contentView.addSubview(whiteView)
        
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceFromButton)
        image.addSubview(activityIndicator)
        
        
    }
    
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            whiteView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 130),
            whiteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            whiteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            whiteView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
        ])
        
        image.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceFromButton.translatesAutoresizingMaskIntoConstraints = false
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            image.heightAnchor.constraint(equalToConstant: 220),
            
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 60),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            priceFromButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            priceFromButton.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -120),
            priceFromButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            priceFromButton.heightAnchor.constraint(equalToConstant: 30),
            priceFromButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: image.topAnchor, constant: 20),
            activityIndicator.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 20),
            activityIndicator.trailingAnchor.constraint(equalTo: image.trailingAnchor, constant: -20),
            activityIndicator.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -20)
        ])
    }
    
}

extension MenuTableViewBigCell: MenuTableViewCellInputProtocol {
    
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


extension MenuTableViewBigCell {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        shrink()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        expand()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        expand()
    }
    
    func shrink() {
        let shrinkAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        shrinkAnimation?.toValue = NSValue(cgSize: CGSize(width: 0.93, height: 0.93))
        shrinkAnimation?.duration = 0.3
        layer.pop_add(shrinkAnimation, forKey: "shrink")
    }
    
    func expand() {
        let releaseAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        releaseAnimation?.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        releaseAnimation?.velocity = NSValue(cgPoint: CGPoint(x: 1, y: 1))
        releaseAnimation?.springBounciness = 0
        layer.pop_add(releaseAnimation, forKey: "shrink")
    }
    
    
}

extension MenuTableViewBigCell {
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touchesMoved")
        
        mvpPresenter?.tableViewCellTouched()
        
    }
    
}
