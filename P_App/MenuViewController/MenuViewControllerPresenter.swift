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
    
    func createMenuTableViewPresenter() -> MenuTableViewPresenterProtocol
    func createMenuTableViewCellPresenter(indexPath: IndexPath) -> MenuTableViewCellPresenter
    
}

class MenuViewControllerPresenter: MenuViewControllerPresenterProtocol {
    
    weak var mvpView: MenuViewControllerInputProtocol?
    
    var tableViewPresenter: MenuTableViewPresenterProtocol?
    
}

extension MenuViewControllerPresenter {
    
    func createMenuTableViewCellPresenter(indexPath: IndexPath) -> MenuTableViewCellPresenter {
        let menuTableViewCellPresenter = MenuTableViewCellPresenter()
        return menuTableViewCellPresenter
    }
    
    
    func createMenuTableViewPresenter() -> MenuTableViewPresenterProtocol {
        let menuTableViewPresenter = MenuTableViewPresenter()
        
        //  создание ссылки на menuTableViewPresenter в MenuViewControllerPresenter для того чтобы в дальнейшем обновлять приходящие из модели данные
        tableViewPresenter = menuTableViewPresenter
        
        return menuTableViewPresenter
    }

    
}


