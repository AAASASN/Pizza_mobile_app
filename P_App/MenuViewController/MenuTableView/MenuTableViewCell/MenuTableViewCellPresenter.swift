//
//  MenuTableViewCellPresenter.swift
//  P_App
//
//  Created by Александр Мараенко on 06.04.2023.
//

import Foundation
import UIKit

protocol MenuTableViewCellPresenterProtocol {
    
    var menuItem: Menu? { get set }
    var mvpView: MenuTableViewCellInputProtocol? { get set }
    var menuTableViewPresenter: MenuTableViewPresenterProtocol? { get set }
    
    func sendDataToView()
    func tableViewCellTouched()
        
}

class MenuTableViewCellPresenter: MenuTableViewCellPresenterProtocol  {
    
    weak var mvpView: MenuTableViewCellInputProtocol?
    
    var mvpModel: NetworkManagerProtocol?
    
    // ????? weak
    var menuTableViewPresenter: MenuTableViewPresenterProtocol?
    
    var menuItem: Menu? {
        didSet {
            print("")
            print("DEBUG MenuTableViewCellPresenter")
            print("var menuItem was changed - \(String(describing: menuItem?.image))")
            print("fetchImage() was start")
            fetchImage(url: menuItem?.image ?? "")
        }
    }
    
    var imageAsData: Data? {
        didSet {
            print("")
            print("DEBUG: в MenuTableViewCellPresenter")
            print("imageAsData was change")
            if let data = imageAsData {
                guard let i = UIImage(data: data) else { return }
                 mvpView?.stopActivityIndicator()
                mvpView?.inputImage(image: i)
            }
        }
    }
    
    init() {
        mvpModel = NetworkManager()
        mvpModel?.mvpPresenter = self
    }
    
    func fetchImage(url: String) {
        mvpModel?.fetchData(url: url)
    }
    
    func sendDataToView() {
        
        mvpView?.inputNameText(name: menuItem?.name ?? "name error")
        mvpView?.inputDescriptionText(description: menuItem?.description ?? "description error")
        mvpView?.inputPriceFromButtonText(PriceFromButtonText: String(menuItem?.priceFrom ?? 0))
        
    }
    
    func tableViewCellTouched() {
        menuTableViewPresenter?.tableViewCellTouched()
    }
    
}

extension MenuTableViewCellPresenter: PresenterInputProtocol {
    
    func getRestMenuValue(restMenuAsData: Data?) {
        
        imageAsData = restMenuAsData

    }
    
    
}
