//
//  MenuViewController.swift
//  P_App
//
//  Created by Александр Мараенко on 03.04.2023.
//

import UIKit

enum Location: String {
    case moscow =  "Москва"
}

// протокол для передачи данных к MenuViewController
protocol MenuViewControllerInputProtocol: AnyObject {
    
    func updateTableView()
    
}


class MenuViewController: UIViewController {
    
    var mvpPresenter: MenuViewControllerPresenterProtocol?
    var tableView: UITableView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.97, alpha: 1.00)
        navigationBarSet()
        tableViewSetting()

    }
    

    func tableViewSetting() {
        
        tableView = {
            
            let tableView = MenuTableView(mvpPresenter: mvpPresenter?.createMenuTableViewPresenter(), frame: .zero, style: .plain)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tableView)
            NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
                                         tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                                         tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
                                         tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
                                        ])
            
            tableView.sectionHeaderTopPadding = 0
            tableView.separatorInset = .zero
            return tableView
        }()
        
    }

}


// MARK: - navigationBarSet
extension MenuViewController {
    
    private func navigationBarSet() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.isTranslucent = true
        navigationBar?.shadowImage = UIImage()
        let leftBarButton = chooseLocationBarButton("Москва")
        leftBarButton.addTarget(self, action: #selector(handleChooseLocationBarButton), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
    }
    
    @objc func handleChooseLocationBarButton () {
        print("DEBUG: handleChooseLocationBarButton ")
    }
    
    func chooseLocationBarButton(_ locationString: String) -> UIButton {
        let button = UIButton(type: .system)
        let icon = UIImage(named: "arrow-down")!
        icon.withTintColor(.black)
        button.setTitle(locationString, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 3, left: 0, bottom: 0, right: -10)
        button.setImage(icon.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
}


extension MenuViewController: MenuViewControllerInputProtocol {
    
    func updateTableView() {
        tableView?.reloadData()
    }
    
}
