//
//  CategoryCollectionViewCellPresenter.swift
//  P_App
//
//  Created by Александр Мараенко on 04.04.2023.
//

import Foundation

protocol CategoryCollectionViewCellPresenterProtocol {
    
    var category: Category? { get set }
    var mvpView: CategoryCollectionViewCellInputProtocol? { get set }
    func sendDataToView()
    
}

class CategoryCollectionViewCellPresenter: CategoryCollectionViewCellPresenterProtocol {

    var category: Category?
    
    weak var mvpView: CategoryCollectionViewCellInputProtocol?
    
    func sendDataToView() {
        mvpView?.setStreamTitle(str: category?.name ?? "error name")  //streamTitle.text = category?.name
    }
    
}
