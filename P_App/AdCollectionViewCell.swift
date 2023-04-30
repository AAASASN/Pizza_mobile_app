//
//  AdCollectionViewCell.swift
//  P_App
//
//  Created by Александр Мараенко on 04.04.2023.
//

import Foundation
import UIKit

protocol AdCollectionViewCellInputProtocol: AnyObject {
    
    var mvpPresenter: AdCollectionViewCellPresenterProtocol? { get set }
    
    func inputImage(image: UIImage)
    
}

class AdCollectionViewCell: UICollectionViewCell {
    
    var mvpPresenter: AdCollectionViewCellPresenterProtocol?
    
    let adView: UIView = {
        
        let adView = UIView(frame: CGRect(x: 0, y: 0, width: 260, height: 112))
        adView.layer.cornerRadius = 20
        adView.clipsToBounds = true
        return adView
        
    }()
    
    let adImageViewView: UIImageView = {
        
        let adImageViewView = UIImageView(frame: CGRect(x: 0, y: 0, width: 260, height: 112))
        
//        adImageViewView.backgroundColor = .green
//        adImageViewView.layer.cornerRadius = 20
        
        adImageViewView.contentMode = .scaleAspectFit
        
        return adImageViewView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(adView)
        adView.addSubview(adImageViewView)
        
        layer.cornerRadius = 10
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AdCollectionViewCell: AdCollectionViewCellInputProtocol {
    
    func inputImage(image: UIImage) {
        self.adImageViewView.image = image
    }
    
}
