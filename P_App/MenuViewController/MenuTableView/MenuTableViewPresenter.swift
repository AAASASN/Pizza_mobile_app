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
    
//    func numberOfSectionsInMenuTableView() -> Int
    func getNumberOfRowsInSection() -> Int
    
    func createMenuTableViewCellPresenter(indexPath: IndexPath) -> MenuTableViewCellPresenter
    func createCategoryCollectionView() -> CategoryCollectionView
    func createAdCollectionView() -> AdCollectionView
    
    func sendSelectedCategory(categoryID: Int)
    func willDisplayCell(cellRow: Int)
    
}

class MenuTableViewPresenter: MenuTableViewPresenterProtocol, PresenterInputProtocol {
    

    func sendSelectedCategory(categoryID: Int) {
        mvpView?.selectedCategory(categoryID: categoryID)
    }
    
    func willDisplayCell(cellRow: Int) {
        guard let categoryID = menu?[cellRow].categoryID else { return }
        
//        print("")
//        print("DEBUG MenuTableViewPresenter")
//        print("в MenuTableViewPresenter отпработал метод willDisplay - будет отображена ячейка с индексом \(cellRow)  ")
        
        guard let categoryCollectionViewPresenter = categoryCollectionViewPresenter else {
            print("")
            print("DEBUG MenuTableViewPresenter")
            print("Экземпляр categoryCollectionViewPresenter не был создан")
            return
        }
        categoryCollectionViewPresenter.willDisplayCellWithCategory(categoryID: categoryID)
    }
    
    weak var mvpView: MenuTableViewInputProtocol?
    
    weak var categoryCollectionViewPresenter: CategoryCollectionViewPresenterProtocol?

    
    var menu: [Menu]? {
        
        didSet {
            print("")
            print("DEBUG MenuTableViewPresenter")
            print("значение menu: [Menu]? было изменен ")
            
            mvpView?.updateTableView()
            print("был вызван метод mvpView?.updateTableView() для обнавления таблицы")

        }
        
    }
    
    var banners: [Banner]?
    
    var categories: [Category]?
    
    var networkManager: NetworkManagerProtocol?
    let mealsUrl = "http://127.0.0.1:8080/api/meals"

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
                let someRestMenu = try decoder.decode([Menu].self, from: restMenuAsData )
                
                menu = someRestMenu

    //            menu = someRestMenu.data?.menu
    //            banners = someRestMenu.data?.banners
    //            categories = someRestMenu.data?.categories
                
                print("")
                print("DEBUG MenuTableViewPresenter")
                print("массив [Menu] успешно декодирован из restMenuAsData и присвоен self.menu")
                
                
                
            } catch let error {
                print("JSONDecoder не отработал \(error)")
            }

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

}
