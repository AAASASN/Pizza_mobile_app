//
//  MenuViewControllerPresenter.swift
//  P_App
//
//  Created by Александр Мараенко on 04.04.2023.
//

import Foundation

// протокол для передачи данных от NetworkManager к MenuViewControllerPresenter
protocol PresenterInputProtocol: AnyObject {
    
    func getRestMenuValue(restMenuAsData: Data?)
    
}

// протокол описывающий работу MenuViewControllerPresenter
protocol MenuViewControllerPresenterProtocol {
    
    var mvpView: MenuViewControllerInputProtocol? { get set }
//    var menu: [Menu]? { get }
//    var banners: [Banner]? { get }
//    var categories: [Category]? { get }
    
    func createMenuTableViewPresenter() -> MenuTableViewPresenterProtocol
    func createMenuTableViewCellPresenter(indexPath: IndexPath) -> MenuTableViewCellPresenter
    
}

class MenuViewControllerPresenter: MenuViewControllerPresenterProtocol {
    
//    let url = "https://my-json-server.typicode.com/AAASASN/Test_Task_3_db/db"
//    let mealsUrl = "http://127.0.0.1:8080/api/meals"
//    let bannersUrl = "http://127.0.0.1:8080/api/banners"
//    let categoriesUrl = "http://127.0.0.1:8080/api/categories"
//
    
//    var mvpModel: NetworkManagerProtocol?
    
    weak var mvpView: MenuViewControllerInputProtocol?

    var tableViewPresenter: MenuTableViewPresenterProtocol?
    
    
//    var restMenuAsData: Data? {
//
//        didSet {
//
//            print("")
//            print("DEBUG: в MenuViewControllerPresenter")
//            print("restMenuAsData was change")
//            print("restMenuAsData =")
//            print(restMenuAsData)
//            print("")
//
//
////            getMenuBannersAndCategoriesFromData(restMenuAsData: restMenuAsData)
//
//        }
//    }
    
//    var menu: [Menu]? {
//        didSet {
//            print("")
//            print("DEBUG MenuViewControllerPresenter")
//            print("в свойсто menu было изенено")
//            print("в свойсто menu?[0].name пришло значение = \(String(describing: menu?[0].name))")
//            print("затем в MenuTableViewPresenter передается значение menu ")
//
//            tableViewPresenter?.menu = menu
//        }
//    }
    
//    var banners: [Banner]? {
//        didSet {
//            print("")
//            print("DEBUG MenuViewControllerPresenter")
//            print("в свойсто banners было изенено")
//            print("в свойсто banners?[0].image пришло значение = \(String(describing: banners?[0].image))")
//            print("затем в MenuTableViewPresenter передается значение banners ")
//            tableViewPresenter?.banners = banners
//        }
//    }
//
//    var categories: [Category]? {
//        didSet {
//            print("")
//            print("DEBUG MenuViewControllerPresenter")
//            print("в свойсто categories было изенено")
//            print("в свойсто banners?[0].image пришло значение = \(String(describing: categories?[0].name))")
//            print("затем в MenuTableViewPresenter передается значение banners ")
//            tableViewPresenter?.categories = categories
//        }
//    }
    
//    init() {
//        mvpModel = NetworkManager()
//        mvpModel?.mvpPresenter = self
//        self.mvpModel?.fetchData(url: mealsUrl)
//    }
    
}

// подписываемся на протокол MenuViewControllerPresenterInputProtocol и
// через его метод передаем данные от NetworkManager к MenuViewControllerPresenter
//extension MenuViewControllerPresenter: PresenterInputProtocol {
//
//    func getRestMenuValue(restMenuAsData: Data?) {
//        self.restMenuAsData = restMenuAsData
//        print("")
//        print("DEBUG MenuViewControllerPresenter")
//        print("выполнен метод getRestMenuValue - с его помощью NetworkManager передает и обновляет данные в restMenuAsData в MenuViewController")
//
//    }
//
//}

extension MenuViewControllerPresenter {
    
    func createMenuTableViewCellPresenter(indexPath: IndexPath) -> MenuTableViewCellPresenter {
        let menuTableViewCellPresenter = MenuTableViewCellPresenter()
//        menuTableViewCellPresenter.menuItem = menu?[indexPath.row]
        return menuTableViewCellPresenter
    }
    
    
    func createMenuTableViewPresenter() -> MenuTableViewPresenterProtocol {
        let menuTableViewPresenter = MenuTableViewPresenter()
//        menuTableViewPresenter.menu = self.menu
        
        //  создание ссылки на menuTableViewPresenter в MenuViewControllerPresenter для того чтобы в дальнейшем обновлять приходящие из модели данные
        tableViewPresenter = menuTableViewPresenter
        
        return menuTableViewPresenter
    }
    
//    func getMenuBannersAndCategoriesFromData(restMenuAsData: Data?) {
//
//        guard let restMenuAsData = restMenuAsData else { return }
//
//        print("")
//        print("DEBUG: в MenuViewControllerPresenter")
//        print("в метод getMenuBannersAndCategoriesFromData пришло значение restMenuAsData ")
//        print("restMenuAsData =")
//        print(restMenuAsData)
//        print("")
//
//        do {
//
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            let someRestMenu = try decoder.decode([Menu].self, from: restMenuAsData )
//
////            menu = someRestMenu
//
////            menu = someRestMenu.data?.menu
////            banners = someRestMenu.data?.banners
////            categories = someRestMenu.data?.categories
//
//            print("")
//            print("DEBUG MenuViewControllerPresenter")
//            print("выполнен getMenuBannersAndCategoriesFromData(data: Data?)")
//
//
//
//        } catch let error {
//            print("JSONDecoder не отработал \(error)")
//        }
//
//    }
    
}


