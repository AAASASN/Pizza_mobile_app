//
//  NetworkManager.swift
//  P_App
//
//  Created by Александр Мараенко on 05.04.2023.
//


import Foundation
import Alamofire

// протокол описывающий работу NetworkManager
protocol NetworkManagerProtocol {
    
    var mvpPresenter: PresenterInputProtocol? { get set }
    func fetchData(url: String)

}

class NetworkManager: NetworkManagerProtocol {
        
    weak var mvpPresenter: PresenterInputProtocol?

    var data: Data? {
        didSet {
            guard let data = data else { return print("в didSet (restMenu) прищел nil ") }
            print("")
            print("DEBUG в NetworkManager")
            print("data was change")
            mvpPresenter?.getRestMenuValue(restMenuAsData: data )
        }
    }
    
    internal func fetchData(url: String) {

        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data) :
                self.data = data
            case .failure(let error):
                print("Ошибка \(error)")
            }
        }

    }

}

