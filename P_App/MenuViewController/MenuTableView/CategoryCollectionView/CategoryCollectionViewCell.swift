//
//  CategoryCollectionViewCell.swift
//  P_App
//
//  Created by Александр Мараенко on 03.04.2023.
//

import Foundation
import UIKit


protocol CategoryCollectionViewCellInputProtocol: AnyObject {
    
    var mvpPresenter: CategoryCollectionViewCellPresenterProtocol? { get set }
    var streamTitle: UILabel { get set }
    
    func setStreamTitle(str: String)
    
}


class CategoryCollectionViewCell: UICollectionViewCell {
    
    var mvpPresenter: CategoryCollectionViewCellPresenterProtocol?
    
    var streamTitle: UILabel = {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 32))
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 0.60)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    override var isSelected: Bool {
        
        didSet {
            
            layer.borderWidth = self.isSelected ? 0 : 1
            backgroundColor = self.isSelected ?
            UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 0.20) :
            UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1.00)
            
            streamTitle.textColor =  self.isSelected ?
            UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00) :
            UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 0.60)
            
            streamTitle.font = self.isSelected ?
                .boldSystemFont(ofSize: 14) :
                .systemFont(ofSize: 14, weight: .regular)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        constraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView(){
        
        backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1.00)
        layer.cornerRadius = self.frame.height/2
        layer.borderColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 0.60).cgColor
        layer.borderWidth = 1
        addSubview(streamTitle)
    }
    
    func setSelectedView() {
        layer.borderWidth = 0
        backgroundColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 0.20)
        streamTitle.textColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00)
        streamTitle.font = .boldSystemFont(ofSize: 14)
    }
    
    private func constraints(){
        NSLayoutConstraint.activate([
            streamTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            streamTitle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension CategoryCollectionViewCell: CategoryCollectionViewCellInputProtocol {
    
    func setStreamTitle(str: String) {
        streamTitle.text = str
    }
    
}
