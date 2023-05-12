//
//  AdCollectionViewPresenter.swift
//  P_App
//
//  Created by Александр Мараенко on 04.04.2023.
//

import Foundation

protocol AdCollectionViewPresenterProtocol {
    
    var banners: [Banner]? { get set }
    var mvpView: AdCollectionViewInputProtocol? { get set }
    
    func getnumberOfItemsInSection() -> Int
    func createAdCollectionViewCellPresenter(indexPath: IndexPath) -> AdCollectionViewCellPresenterProtocol
        
}

class AdCollectionViewPresenter: AdCollectionViewPresenterProtocol, PresenterInputProtocol {

    weak var mvpView: AdCollectionViewInputProtocol?

    var banners: [Banner]? {
        
        didSet {
            print("")
            print("DEBUG AdCollectionViewPresenter")
            print("значение categories: [Banner]? было изменен ")
    
            mvpView?.updateCollectionView()
            print("был вызван метод mvpView?.updateCollectionView() для обнавления коллекции")

        }
        
    }
    
    var networkManager: NetworkManagerProtocol?
    let bannersUrl = "http://165.22.199.40:8080/api/banners"

    init() {
        networkManager = NetworkManager()
        networkManager?.mvpPresenter = self
        self.networkManager?.fetchData(url: bannersUrl)
    }
    
    func getRestMenuValue(restMenuAsData: Data?) {
        guard let restMenuAsData = restMenuAsData else { return }
        
        print("")
        print("DEBUG: в AdCollectionViewPresenter")
        print("в метод getRestMenuValue пришло значение restMenuAsData ")
        print("restMenuAsData =")
        print(restMenuAsData)
        print("")
        
        do {
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let banners = try decoder.decode([Banner].self, from: restMenuAsData )
            
            self.banners = banners

//            menu = someRestMenu.data?.menu
//            banners = someRestMenu.data?.banners
//            categories = someRestMenu.data?.categories
            
            print("")
            print("DEBUG AdCollectionViewPresenter")
            print("массив [Category] успешно декодирован из restMenuAsData и присвоен self.categories")
            
            
            
        } catch let error {
            print("JSONDecoder не отработал \(error)")
        }
    }
    
    func getnumberOfItemsInSection() -> Int {
        
        guard let banners = banners else {
            
            print("")
            print("DEBUG AdCollectionViewPresenter")
            print("при попытке получить banners?.count получили nil ")
            print("возвращаем 0")
            return 0
            
        }
        
        print("")
        print("DEBUG AdCollectionViewPresenter")
        print("отработал getNumberOfRowsInSection() - вернул \(banners.count)")
        return banners.count
        
    }
    
    func createAdCollectionViewCellPresenter(indexPath: IndexPath) -> AdCollectionViewCellPresenterProtocol {
        
        let adCollectionViewCellPresenter = AdCollectionViewCellPresenter()
        adCollectionViewCellPresenter.banner = banners?[indexPath.row]
        return adCollectionViewCellPresenter
    }
    
}

