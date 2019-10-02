//
//  ServantTableViewController.swift
//  FateIndex+
//
//  Created by 管君 on 9/26/18.
//  Copyright © 2018 管君. All rights reserved.
//

import UIKit

class ServantTableViewController: UITableViewController {

    private struct Constants {
        static let defaultCellHeight: CGFloat = 75.0

        static let servantClasses = [
            "Saber", "Archer", "Lancer", "Rider", "Caster", "Assassin", "Berserker",
            "Shielder", "Ruler", "Avenger", "MoonCancer", "Alterego", "Foreigner"
        ]
    }

    private let searchController = UISearchController(searchResultsController: nil)

    private var servants = ServantManager.shared.allServants()

    private lazy var servantsDict = {
        return Dictionary(grouping: servants, by: { $0.classType })
    }()

    private var filteredServants = [Servant]()
    // private var filteredServants = [ServantClass : [Servant]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ServantTableViewCell.self, forCellReuseIdentifier: ServantTableViewCell.identifier)
        tableView.register(ServantTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: ServantTableViewHeaderView.identifier)

        setupSearchViewController()
    }

    // MARK:- UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering() {
            return 1
        }
        else {
            return Constants.servantClasses.count
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredServants.count
        }
        else {
            let servantClass = ServantClass(name: Constants.servantClasses[section])
            return servantsDict[servantClass]?.count ?? 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServantTableViewCell", for: indexPath) as! ServantTableViewCell

        if isFiltering() {
            cell.avatar = UIImage(named: "Servant_\(filteredServants[indexPath.row].id)")
            cell.title = filteredServants[indexPath.row].name
            return cell
        }
        else {
            let servantClass = ServantClass(name: Constants.servantClasses[indexPath.section])
            cell.avatar = UIImage(named: "Servant_\(servantsDict[servantClass]![indexPath.row].id)")
            cell.title = servantsDict[servantClass]?[indexPath.row].name
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.defaultCellHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isFiltering() {
            return nil
        }

        let servantClass = ServantClass(name: Constants.servantClasses[section])
        if let hasServant = servantsDict[servantClass], hasServant.isEmpty {
            return nil
        }

        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ServantTableViewHeaderView.identifier) as! ServantTableViewHeaderView

        headerView.title = servantClass.name
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37.5
    }

    // MARK:- UITableViewDelegate

    private func setupSearchViewController() {
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "搜索从者"

        searchController.searchBar.scopeButtonTitles = [
            "编号", "ATK降序", "HP降序", "活动赠送"
        ]
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension ServantTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }

    private func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private func filterContentForSearchText(_ searchText: String, scope: String = "编号") {
        filteredServants = servants.filter { servant in
            if searchText == "" {
                return true
            }
            return servant.name.lowercased().contains(searchText.lowercased())
        }.sorted {
            if scope == "编号" {
                return $0.id < $1.id
            }
            else if scope == "ATK降序" {
                return $0.maxATK > $1.maxATK
            }
            else if scope == "HP降序" {
                return $0.maxHP > $1.maxHP
            }
            else {
                return $0.id < $1.id
            }
        }

        if scope == "活动赠送" {
            filteredServants = filteredServants.filter { $0.giftFromEvent }
        }

        tableView.reloadData()
    }

    private func isFiltering() -> Bool {
      let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
      return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }

}

extension ServantTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
      filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
