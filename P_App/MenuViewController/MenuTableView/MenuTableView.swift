//
//  MenuTableView.swift
//  P_App
//
//  Created by Александр Мараенко on 10.04.2023.
//

import UIKit


protocol MenuTableViewInputProtocol: AnyObject {
    
    func updateTableView()
    func selectedCategory(categoryID: Int)
    
}


protocol MenuTableViewProtocol {
    
    var mvpPresenter: MenuTableViewPresenterProtocol? { get set }
        
}


class MenuTableView: UITableView, MenuTableViewProtocol {
    
    var mvpPresenter: MenuTableViewPresenterProtocol?

    init(mvpPresenter: MenuTableViewPresenterProtocol?, frame: CGRect, style: UITableView.Style) {
        
        super.init(frame: frame, style: style)
        
        var mvpPresenter = mvpPresenter
        mvpPresenter?.mvpView = self
        self.mvpPresenter = mvpPresenter

        self.register(MenuTableViewCell.self, forCellReuseIdentifier: "MenuTableViewCell")

        
        // !!!!!!!!!!!!!!!!!!!!
        backgroundColor = UIColor(red: 243, green: 245, blue: 249, alpha: 1)
        
        
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - DataSource Delegate
extension MenuTableView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 0
        } else {
            guard let count = mvpPresenter?.getNumberOfRowsInSection() else {
                print("")
                print("DEBUG MenuTableView")
                print("в MenuTableView не удалось получить numberOfRowsInSection")
                return 0
            }
            print("")
            print("DEBUG MenuTableView")
            print("получено numberOfRowsInSection = \(String(describing: count))")
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        if indexPath.section == 1 {
            let mvpPresenter = mvpPresenter?.createMenuTableViewCellPresenter(indexPath: indexPath)
            mvpPresenter?.mvpView = cell
            cell.mvpPresenter = mvpPresenter
            cell.mvpPresenter?.sendDataToView()
            cell.startActivityIndicator()
            cell.image.image = nil
//            if indexPath.row == 0 {
//                cell.contentView.layer.cornerRadius = 25
//                cell.layer.masksToBounds = true
//                cell.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            let view = mvpPresenter?.createCategoryCollectionView()
//            view?.mvpPresenter?.menuTableViewPresenter = self.mvpPresenter
            return view
        }
        
        return UIView(frame: .zero)
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            let view = mvpPresenter?.createAdCollectionView()
//            let view = AdCollectionView()
            return view
        }
        
        return UIView(frame: .zero)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        } else {
            return 70
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 90
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        180
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        print("")
//        print("DEBUG MenuTableView")
//        print("в MenuTableView отпработал метод willDisplay - будет отображена ячейка с индексом \(indexPath.row)  ")
        
        mvpPresenter?.willDisplayCell(cellRow: indexPath.row)
    }
    
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        mvpPresenter?.willDisplayCell(cellRow: indexPath.row)
//
//    }
    
    
}

extension MenuTableView: MenuTableViewInputProtocol {
    
    func updateTableView() {
        reloadData()
    }
    
    func selectedCategory(categoryID: Int) {
    
        var indexArray: [Int] = .init()

        guard let menu = mvpPresenter?.menu  else {
            print("")
            print("DEBUG MenuTableView")
            print("в при попытке получить массив menu из mvpPresenter?.menu вернулся nil")
            return }

        for (index, item) in menu.enumerated() {
            if item.categoryID == categoryID + 1 {
                indexArray.append(index)
            }
        }
        guard !indexArray.isEmpty else { return }
        self.scrollToRow(at: IndexPath(row: indexArray.first!, section: 1), at: .top, animated: true)
   
    }
    
}



