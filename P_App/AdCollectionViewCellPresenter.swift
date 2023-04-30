//
//  AdCollectionViewCellPresenter.swift
//  P_App
//
//  Created by Александр Мараенко on 04.04.2023.
//

import Foundation
import UIKit

protocol AdCollectionViewCellPresenterProtocol {
    
    var banner: Banner? { get set}
    var mvpView: AdCollectionViewCellInputProtocol? { get set }
        
}

class AdCollectionViewCellPresenter: AdCollectionViewCellPresenterProtocol, PresenterInputProtocol {
    
    weak var mvpView: AdCollectionViewCellInputProtocol?
    
    var banner: Banner? {
        didSet {
            print("")
            print("DEBUG AdCollectionViewCellPresenter")
            print("var banner was changed - \(String(describing: banner?.image))")
            print("fetchImage() was start")
            fetchImage(url: banner?.image ?? "")
        }
    }
        
    var mvpModel: NetworkManagerProtocol?
    
    var imageAsData: Data? {
        didSet {
            print("")
            print("DEBUG: в MenuTableViewCellPresenter")
            print("imageAsData was change")
            if let data = imageAsData {
                guard let i = UIImage(data: data) else { return }
//                 mvpView?.stopActivityIndicator()
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
    
    func getRestMenuValue(restMenuAsData: Data?) {
        imageAsData = restMenuAsData
    }
    
//    func sendDataToView() {
//
//        mvpView?.inputNameText(name: menuItem?.name ?? "name error")
//        mvpView?.inputDescriptionText(description: menuItem?.description ?? "description error")
//        mvpView?.inputPriceFromButtonText(PriceFromButtonText: String(menuItem?.priceFrom ?? 0))
//
//    }
    

}


