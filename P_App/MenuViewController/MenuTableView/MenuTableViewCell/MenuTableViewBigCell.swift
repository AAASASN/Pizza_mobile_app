//
//  MenuTableViewBigCell.swift
//  P_App
//
//  Created by Александр Мараенко on 11.05.2023.
//


import UIKit
import pop

//protocol MenuTableViewCellInputProtocol: AnyObject {
//
//    func inputImage(image: UIImage)
//    func inputNameText(name: String)
//    func inputDescriptionText(description: String)
//    func inputPriceFromButtonText(PriceFromButtonText: String)
//    func startActivityIndicator()
//    func stopActivityIndicator()
//
//}

class MenuTableViewBigCell: UITableViewCell {
    
    var mvpPresenter: MenuTableViewCellPresenterProtocol?
    
    var image: UIImageView!
    var activityIndicator: UIActivityIndicatorView!
    var nameLabel: UILabel!
    var descriptionLabel: UILabel!
    var priceFromButton: UIButton!
    
//    let panGestureRecognizer = UIPanGestureRecognizer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//                contentView.backgroundColor = .lightGray
        
        createCellElements()
        addAllSubviews()
        setConstraints()
        
        self.selectionStyle = .none
        backgroundColor = .white
        
//        contentView.addGestureRecognizer(panGestureRecognizer)
//
//        panGestureRecognizer.addTarget(self, action: #selector(handleTapGesture(_:)))
//
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    @objc func handleTapGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
//
//        print("touchesMoved")
//
//        mvpPresenter?.tableViewCellTouched()
//
//    }
    
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
            nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
            
            nameLabel.backgroundColor = .systemGray3
            
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
//            priceFromButton.layer.borderWidth = 1
//            priceFromButton.layer.borderColor = UIColor(red: 0.77, green: 0.26, blue: 0.02, alpha: 1.00).cgColor // UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 0.60).cgColor
            priceFromButton.layer.cornerRadius = 15
            priceFromButton.setTitleColor(UIColor(red: 0.77, green: 0.26, blue: 0.02, alpha: 1.00), for: .normal)
            priceFromButton.backgroundColor = UIColor(red: 1.00, green: 0.93, blue: 0.88, alpha: 1.00)
            priceFromButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)//.italicSystemFont(ofSize: 12)
            
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
        
        NSLayoutConstraint.activate([
//            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
//            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            image.heightAnchor.constraint(equalToConstant: 140),
            image.widthAnchor.constraint(equalToConstant: 140),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 32),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -70),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            priceFromButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -56),
//            priceFromButton.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -113),
            priceFromButton.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 32),
            priceFromButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -130),
            priceFromButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
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
