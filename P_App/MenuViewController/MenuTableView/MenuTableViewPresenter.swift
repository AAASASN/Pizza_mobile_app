//
//  MenuTableViewPresenter.swift
//  P_App
//
//  Created by Александр Мараенко on 10.04.2023.
//

import Foundation

protocol MenuTableViewPresenterProtocol {
    
    var menu: [Menu]? { get set }
    var banners: [Banner]? { get set }
    var categories: [Category]? { get set }
    
    var mvpView: MenuTableViewInputProtocol? { get set }
    var categoryCollectionViewPresenter: CategoryCollectionViewPresenterProtocol? { get set }
    
    func getNumberOfRowsInSection() -> Int
    
    func createMenuTableViewCellPresenter(indexPath: IndexPath) -> MenuTableViewCellPresenter
    func createCategoryCollectionView() -> CategoryCollectionView
    func createAdCollectionView() -> AdCollectionView
    
    func sendSelectedCategory(categoryID: Int)
    func willDisplayCell(cellRow: Int)
    
    func tableViewCellTouched()
    
    func getNumberOfSections() -> Int
    
    func isShouldCellBig(indexPath: IndexPath) -> Bool
    
}

class MenuTableViewPresenter: MenuTableViewPresenterProtocol, PresenterInputProtocol {
    
    weak var mvpView: MenuTableViewInputProtocol?
    
    weak var categoryCollectionViewPresenter: CategoryCollectionViewPresenterProtocol?

    
    var menu: [Menu]? {
        
        didSet {
            print("")
            print("DEBUG MenuTableViewPresenter")
            print("значение menu: [Menu]? было изменен ")
            
            mvpView?.updateTableView()
            print("был вызван метод mvpView?.updateTableView() для обнавления таблицы")

            createIndexForBigCell()
        }
        
    }
    
    var indexForBigCell = [Int]()
    
    var banners: [Banner]?
    
    var categories: [Category]?
    
    var networkManager: NetworkManagerProtocol?
    let mealsUrl = "http://165.22.199.40:8080/api/meals"

    init() {
        networkManager = NetworkManager()
        networkManager?.mvpPresenter = self
        self.networkManager?.fetchData(url: mealsUrl)
    }
    
    func getRestMenuValue(restMenuAsData: Data?) {
        
            guard let restMenuAsData = restMenuAsData else { return }
            
            print("")
            print("DEBUG: в MenuTableViewPresenter")
            print("в метод getRestMenuValue пришло значение restMenuAsData ")
            print("restMenuAsData =")
            print(restMenuAsData)
            print("")
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                var someRestMenu = try decoder.decode([Menu].self, from: restMenuAsData )
                
                someRestMenu.sort {( s1, s2) in
                    let indexS1 = String(s1.categoryId ?? 0) + String(s1.appId ?? 0)
                    let indexS2 = String(s2.categoryId ?? 0) + String(s2.appId ?? 0)
                    return indexS1 < indexS2
                }
                
                menu = someRestMenu
                
                print("")
                print("DEBUG MenuTableViewPresenter")
                print("массив [Menu] успешно декодирован из restMenuAsData и присвоен self.menu")
                
                
                
            } catch let error {
                print("JSONDecoder не отработал \(error)")
            }

    }
    
    func getNumberOfSections() -> Int {

        var sectionTypeArray = [Int]()
        
        guard let menu = menu else { return 1 } // позвращается одна секция
        
        for meal in menu {
            if let mealCategoryId = meal.categoryId {
                if !sectionTypeArray.contains(mealCategoryId) {
                    sectionTypeArray.append(mealCategoryId)
                }
            }
        }
        
        print("")
        print("DEBUG MenuTableViewPresenter")
        print("sectionTypeArray.count -")
        print(sectionTypeArray.count)
        print("")
        print(sectionTypeArray)
        print("")

        return 0
    }
    
    func getNumberOfRowsInSection() -> Int {
        
        guard let menu = menu else {
            print("")
            print("DEBUG MenuTableViewPresenter")
            print("метод getNumberOfRowsInSection() -> Int вернул 0 потомучто menu пустое")
            return 0
        }
        
        let valueForReturn = menu.count
        
        print("")
        print("DEBUG MenuTableViewPresenter")
        print("метод getNumberOfRowsInSection() -> Int вернул \(valueForReturn)")
        
        return valueForReturn
    }
    
    
    func createMenuTableViewCellPresenter(indexPath: IndexPath) -> MenuTableViewCellPresenter {
        let menuTableViewCellPresenter = MenuTableViewCellPresenter()
        menuTableViewCellPresenter.menuItem = menu?[indexPath.row]
        menuTableViewCellPresenter.menuTableViewPresenter = self
        return menuTableViewCellPresenter
    }

    
    func createCategoryCollectionView() -> CategoryCollectionView {
        
        let categoryCollectionView = CategoryCollectionView()
        let categoryCollectionViewPresenter = CategoryCollectionViewPresenter()
        categoryCollectionViewPresenter.categories = categories
        categoryCollectionViewPresenter.mvpView = categoryCollectionView
        categoryCollectionViewPresenter.menuTableViewPresenter = self
        categoryCollectionView.mvpPresenter = categoryCollectionViewPresenter
        
        self.categoryCollectionViewPresenter = categoryCollectionViewPresenter
        
        return categoryCollectionView
        
    }
    
    func createAdCollectionView() -> AdCollectionView {
        let adCollectionView = AdCollectionView()
        let adCollectionViewPresenter = AdCollectionViewPresenter()
        adCollectionViewPresenter.banners = banners
        adCollectionViewPresenter.mvpView = adCollectionView
        adCollectionView.mvpPresenter = adCollectionViewPresenter
        return adCollectionView
    }
    
    
    func tableViewCellTouched() {
        mvpView?.tableViewCellTouched()
    }
    
    func sendSelectedCategory(categoryID: Int) {
        mvpView?.selectedCategory(categoryID: categoryID)
    }
    
    func willDisplayCell(cellRow: Int) {
        guard let categoryID = menu?[cellRow].categoryId else { return }
        
        guard let categoryCollectionViewPresenter = categoryCollectionViewPresenter else {
            print("")
            print("DEBUG MenuTableViewPresenter")
            print("Экземпляр categoryCollectionViewPresenter не был создан")
            
            return
        }
        categoryCollectionViewPresenter.willDisplayCellWithCategory(categoryID: categoryID)
    }
    
    func createIndexForBigCell() {
        var indexForBigCell = [Int]()
        guard let menu = menu else { return }
        for (index, item) in menu.enumerated() {
            print(index,item )
            if item.appId == 1 {
                indexForBigCell.append(index)
            }
        }
        self.indexForBigCell = indexForBigCell
    }
    
    func isShouldCellBig(indexPath: IndexPath) -> Bool {
        
        if indexForBigCell.contains(indexPath.row) {
            return true
        } else {
            return false
        }
        
    }

}
