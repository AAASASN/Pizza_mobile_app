//
//  CategoryCollectionViewPresenter.swift
//  P_App
//
//  Created by Александр Мараенко on 04.04.2023.
//

import Foundation

protocol CategoryCollectionViewPresenterProtocol: AnyObject {
    
    var categories: [Category]? { get set }
        
    var mvpView: CategoryCollectionViewProtocol? { get set }
    
    var menuTableViewPresenter: MenuTableViewPresenterProtocol? { get set }
    
    func getnumberOfItemsInSection() -> Int
    func sendSelectedCategory(categoryID: Int)
    func willDisplayCellWithCategory(categoryID: Int)
    
    func createCategoryCollectionViewCellPresenter(indexPath: IndexPath) -> CategoryCollectionViewCellPresenter?
    
}

class CategoryCollectionViewPresenter: CategoryCollectionViewPresenterProtocol, PresenterInputProtocol {

    var categories: [Category]? {
        
        didSet {
            print("")
            print("DEBUG CategoryCollectionViewPresenter")
            print("значение categories: [Category]? было изменен ")
            
            mvpView?.updateCollectionView()
            print("был вызван метод mvpView?.updateTableView() для обнавления таблицы")

        }
        
    }
    
    weak var mvpView: CategoryCollectionViewProtocol?
    
    // презентер для передачи данных о нажатой категории на CategoryCollectionView
    var menuTableViewPresenter: MenuTableViewPresenterProtocol?
    
    var networkManager: NetworkManagerProtocol?
    let categoriesUrl = "http://165.22.199.40:8080/api/categories"

    init() {
        networkManager = NetworkManager()
        networkManager?.mvpPresenter = self
        self.networkManager?.fetchData(url: categoriesUrl)
    }
    
    func getRestMenuValue(restMenuAsData: Data?) {
        guard let restMenuAsData = restMenuAsData else { return }
        
        print("")
        print("DEBUG: в CategoryCollectionViewPresenter")
        print("в метод getRestMenuValue пришло значение restMenuAsData ")
        print("restMenuAsData =")
        print(restMenuAsData)
        print("")
        
        do {
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let someRestMenu = try decoder.decode([Category].self, from: restMenuAsData )
            
            categories = someRestMenu

//            menu = someRestMenu.data?.menu
//            banners = someRestMenu.data?.banners
//            categories = someRestMenu.data?.categories
            
            print("")
            print("DEBUG CategoryCollectionViewPresenter")
            print("массив [Category] успешно декодирован из restMenuAsData и присвоен self.categories")
            
            
            
        } catch let error {
            print("JSONDecoder не отработал \(error)")
        }
    }
    
    func getnumberOfItemsInSection() -> Int {
        
        guard let categories = categories else {
            print("")
            print("DEBUG CategoryCollectionViewPresenter")
            print("при попытке получить categories?.count nil ")
            print("возвращаем 0")
            return 0
        }
        
        print("")
        print("DEBUG CategoryCollectionViewPresenter")
        print("отработал getNumberOfRowsInSection() - вернул \(categories.count)")
        return categories.count
    }
    
    
    func createCategoryCollectionViewCellPresenter(indexPath: IndexPath) -> CategoryCollectionViewCellPresenter? {
        
        let categoryCollectionViewCellPresenter = CategoryCollectionViewCellPresenter()
        categoryCollectionViewCellPresenter.category = categories?[indexPath.row]
        return categoryCollectionViewCellPresenter
        
    }
    
    
    func sendSelectedCategory(categoryID: Int) {
        menuTableViewPresenter?.sendSelectedCategory(categoryID: categoryID)
    }
    
    func willDisplayCellWithCategory(categoryID: Int) {
        
        print("")
        print("DEBUG CategoryCollectionViewPresenter")
        print("в CategoryCollectionViewPresenter отпработал метод willDisplayCellWithCategory - будет отображена ячейка с индексом \(categoryID)  ")
        
        mvpView?.willDisplayCellWithCategory(categoryID: categoryID)
    }
}
