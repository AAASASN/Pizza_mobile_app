//
//  CategoryCollectionView.swift
//  P_App
//
//  Created by Александр Мараенко on 03.04.2023.
//

import Foundation
import UIKit


protocol CategoriesCollectionViewDelegate: AnyObject {
    
    func selectedCategory(categoryID: Int)
    
}

protocol CategoryCollectionViewProtocol: AnyObject {
    
    var mvpPresenter: CategoryCollectionViewPresenterProtocol? { get set }
        
    func willDisplayCellWithCategory(categoryID: Int)
    
    // reloadData()
    func updateCollectionView()
    
}

class CategoryCollectionView: UICollectionView, CategoryCollectionViewProtocol {
    
    var selectedCellIndex: Int?
    
    var mvpPresenter: CategoryCollectionViewPresenterProtocol?
    
    
    // флаг на который смотрит метод didSelectItemAt и передает или не передает в MenuTableView данные о скоролинге таблицы
    private var canScrollMenuTableView = true
    
    // weak var сategoriesCollectionViewDelegate: CategoriesCollectionViewDelegate?
    
    private let flowLayout = UICollectionViewFlowLayout()
    // private var shiftedCategory: Category?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        
        // настройка CollectionView
        viewSetting()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // настройка CollectionView
    private func viewSetting() {

        flowLayout.scrollDirection = .horizontal
        
        backgroundColor = .systemGray6
        //UIColor(red: 243, green: 245, blue: 249, alpha: 1)
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        bounces = true
        
        // датасурс и делегат
        delegate = self
        dataSource = self
        
        // регистрация ячейки
        register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
    }
    
    
    // здесь будет реализована прокрутка CategoryCollectionView при скроле основной таблицы MenuTableView
    func willDisplayCellWithCategory(categoryID: Int) {
        
        canScrollMenuTableView = false
        
        self.scrollToItem(at: IndexPath(row: categoryID - 1, section: 0), at: .centeredHorizontally, animated: true)

            selectedCellIndex = categoryID - 1

        reloadData()
        
//        canScrollMenuTableView = true

    }
}
    
extension CategoryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let mvpPresenter = mvpPresenter else {
            print("")
            print("DEBUG CategoryCollectionView")
            print("при попытке получить значение mvpPresenter для вызова методаьgetNumberOfRowsInSection() вернулся nil ")
            print("в качестве numberOfItemsInSection возвращаем 0")
            return 0
        }
        
        return mvpPresenter.getnumberOfItemsInSection()
    }
    
    // возвращает ячейку
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CategoryCollectionViewCell {
            
            let presenter = mvpPresenter?.createCategoryCollectionViewCellPresenter(indexPath: indexPath)
            presenter?.mvpView = cell
            cell.mvpPresenter = presenter
            cell.mvpPresenter?.sendDataToView()
                        
            if let selectedCellIndex = selectedCellIndex {
                if selectedCellIndex == indexPath.row {
                    cell.setSelectedView()
                }
            }
                        
            return cell
        }
        return UICollectionViewCell()
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                        
            mvpPresenter?.sendSelectedCategory(categoryID: indexPath.row)
        
        // проскроливает выеделенную ячейку по центру коллекции
            self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

    }
    
//    // при нажатии на выделенную ячейку снимается выделение
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        if collectionView.cellForItem(at: indexPath)?.isSelected ?? false {
//            collectionView.deselectItem(at: indexPath, animated: true)
//            return false
//        }
//        return true
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let font = UIFont(name: "Arial Bold", size: 14)
        let attributes = [NSAttributedString.Key.font : font as Any]
        
        let someCategory = mvpPresenter?.categories?[indexPath.item].name
        let width = (someCategory?.size(withAttributes: attributes).width ?? 0) + 55

        return CGSize(width: width, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func updateCollectionView() {
        reloadData()
    }
    
}
