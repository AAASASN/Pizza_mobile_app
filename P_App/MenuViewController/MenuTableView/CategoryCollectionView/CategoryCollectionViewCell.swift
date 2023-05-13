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
        label.textColor = UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1.00)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {

        didSet {
            backgroundColor = self.isSelected ?
            UIColor(red: 1.00, green: 0.93, blue: 0.88, alpha: 1.00) :
                .systemGray5 // UIColor(red: 0.94, green: 0.93, blue: 0.96, alpha: 1.00)

            streamTitle.textColor =  self.isSelected ?
            UIColor(red: 0.77, green: 0.26, blue: 0.02, alpha: 1.00) :
            UIColor(red: 0.32, green: 0.32, blue: 0.32, alpha: 1.00)
            
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
        backgroundColor = .systemGray5 //  UIColor(red: 0.94, green: 0.93, blue: 0.96, alpha: 1.00)
        layer.cornerRadius = self.frame.height/2
        addSubview(streamTitle)
    }
    
    func setSelectedView() {
        backgroundColor = UIColor(red: 1.00, green: 0.93, blue: 0.88, alpha: 1.00)
        streamTitle.textColor = UIColor(red: 0.77, green: 0.26, blue: 0.02, alpha: 1.00)
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
