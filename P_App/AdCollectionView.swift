//
//  AdCollectionView.swift
//  P_App
//
//  Created by Александр Мараенко on 04.04.2023.
//

import Foundation
import UIKit

protocol AdCollectionViewInputProtocol: AnyObject {
    
    var mvpPresenter: AdCollectionViewPresenterProtocol? { get set }
    func updateCollectionView() 
}

class AdCollectionView: UICollectionView, AdCollectionViewInputProtocol {
    
    var mvpPresenter: AdCollectionViewPresenterProtocol?
    
    private let flowLayout = UICollectionViewFlowLayout()
   
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: flowLayout)

        viewSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewSetting() {

        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10

        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        bounces = true

        // датасурс и делегат
        delegate = self
        dataSource = self
    
        // регистрация ячейки
        register(AdCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1.00)
    }
}

extension AdCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let mvpPresenter = mvpPresenter else {
            print("")
            print("DEBUG AdCollectionView")
            print("при попытке получить значение mvpPresenter для вызова метода getNumberOfRowsInSection() вернулся nil ")
            print("в качестве numberOfItemsInSection возвращаем 0")
            return 0
        }
        
        return mvpPresenter.getnumberOfItemsInSection()
    }
    
    // возвращает ячейку
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AdCollectionViewCell {
            
            var presenter = mvpPresenter?.createAdCollectionViewCellPresenter(indexPath: indexPath)
            presenter?.mvpView = cell
            cell.mvpPresenter = presenter
//            cell.mvpPresenter?.sendDataToView()
            cell.adImageViewView.image = nil
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 280, height: 80)
    }
    
    func updateCollectionView() {
        reloadData()
    }
}

