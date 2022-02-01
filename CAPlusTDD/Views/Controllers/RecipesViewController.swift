//
//  RecipeViewController.swift
//  CAPlusTDD
//
//  Created by richa.e.srivastava on 23/01/2022.
//

import Foundation


import UIKit

class RecipesViewController: UIViewController {
     var recipeViewModel: RecipeViewModelProtocol?
    public var tableView: UITableView?
    public var errorAlertController: UIAlertController?
    private var dataSource: [RecipeModelElement]?
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Recipe Menu"
        self.configureTableView()
        self.getRecipeDataSource()
    }
    
    func configureTableView() {
        tableView = UITableView(frame: self.view.frame)
        tableView?.register(UINib(nibName: RecipeCustomCell.identifier,bundle: nil),forCellReuseIdentifier: RecipeCustomCell.identifier)
        tableView?.backgroundColor = UIColor.white
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView?.rowHeight = self.view.frame.width - 40
        tableView?.allowsMultipleSelection = true
        if let tableView = tableView {
            view.addSubview(tableView)
        }
        if #available(iOS 10.0, *) {
            tableView?.refreshControl = refreshControl
        } else {
            tableView?.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshRecipeData(_:)), for: .valueChanged)
    }
    
}

// MARK: Table View Data Source & Delegate
extension RecipesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: RecipeCustomCell.identifier, for: indexPath) as? RecipeCustomCell
        if let result = self.dataSource?[indexPath.row] {
            myCell?.configure(model: result)
        }
        myCell?.selectionStyle = .none
        return myCell ?? UITableViewCell()
    }
}

// MARK: Call Recipe View Model Methods
extension RecipesViewController {
    /// Calls RecipeViewModel getAPIData function to update tableview data souce
    func getRecipeDataSource() {
        recipeViewModel?.getAPIData( completion: { (model, error) in
            guard error == nil else {
                self.showAlertView(errorMessage: error?.message.rawValue ?? NetworkErrorType.failed.rawValue)
                return
            }
            
            if let modelUW = model {
                self.dataSource = modelUW
                self.executeInMainThread {
                    self.tableView?.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }
        })
    }
}

// MARK: Helper Method
extension RecipesViewController {
    
    func showAlertView(errorMessage: String) {
        self.errorAlertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        self.errorAlertController?.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        if let alertController = self.errorAlertController {
            self.refreshControl.endRefreshing()
            self.executeInMainThread { self.present(alertController, animated: true, completion: nil)}
        }
    }
    
    @objc private func refreshRecipeData(_ sender: Any) {
        getRecipeDataSource()
    }
    
    func executeInMainThread(_ work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            DispatchQueue.main.async(execute: work)
        }
    }
}
