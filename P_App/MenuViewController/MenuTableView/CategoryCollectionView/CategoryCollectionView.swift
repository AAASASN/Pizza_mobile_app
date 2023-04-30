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
    
    func updateCollectionView()
    
}

class CategoryCollectionView: UICollectionView, CategoryCollectionViewProtocol {
    
    var selectedCellIndex = 0
    
    var mvpPresenter: CategoryCollectionViewPresenterProtocol?
    
    weak var сategoriesCollectionViewDelegate: CategoriesCollectionViewDelegate?
    
    private let flowLayout = UICollectionViewFlowLayout()
    private var shiftedCategory: Category?
    
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
        
        backgroundColor = UIColor(red: 243, green: 245, blue: 249, alpha: 1)
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        bounces = true
        
        // датасурс и делегат
        delegate = self
        dataSource = self
        
        // регистрация ячейки
        register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    
    // здесь будет реализована прокрутка CategoryCollectionView при скроле основной таблицы
    func willDisplayCellWithCategory(categoryID: Int) {
        
        print("")
        print("DEBUG CategoryCollectionView !!!!!!!!!!!!!!!!!!!!!!!!!!")
        print("отработал метод willDisplayCellWithCategory(categoryID: Int) ")
        print("пришел номер категории - \(categoryID)")
        
//        self.scrollToItem(at: IndexPath(row: categoryID - 1, section: 0), at: .centeredHorizontally, animated: true)
//
//        
//            selectedCellIndex = categoryID + 2
//
//        
//
//        reloadData()
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
                        
            
            if selectedCellIndex == indexPath.row {
                cell.setSelectedView()
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // при нажатии на ячейку данные о indexPath передаем в презентер
        mvpPresenter?.sendSelectedCategory(categoryID: indexPath.row)
    }
    
    // при нажатии на выделенную ячейку снимается выделение
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView.cellForItem(at: indexPath)?.isSelected ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
            return false
        }
        return true
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let font = UIFont(name: "Arial Bold", size: 14)
        let attributes = [NSAttributedString.Key.font : font as Any]
        
        let someCategory = mvpPresenter?.categories?[indexPath.item].name
        let width = (someCategory?.size(withAttributes: attributes).width ?? 0) + 55

        return CGSize(width: width, height: 32)
    }
    
    func updateCollectionView() {
        reloadData()
    }
    
}
