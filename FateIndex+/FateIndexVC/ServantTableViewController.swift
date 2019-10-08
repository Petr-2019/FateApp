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
        static let defaultCellHeight: CGFloat = 78.0

        static let servantClasses: [ServantClass] = [
            .saber, .archer, .lancer, .rider,
            .caster, .assassin, .berserker, .shielder,
            .ruler, .avenger, .moonCancer, .alterego,
            .foreigner
        ]

        static let placeHolder = "搜索从者"
        static let idName = "编号"
        static let atkDesc = "ATK降序"
        static let hpDesc = "HP降序"
        static let giftFromEvent = "活动赠送"
    }

    private let searchController = UISearchController(searchResultsController: nil)

    private var servants = ServantManager.shared.allServants()

    private lazy var servantsDict = {
        return Dictionary(grouping: servants, by: { $0.classType })
    }()

    private var filteredServants = [Servant]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ServantTableViewCell.self, forCellReuseIdentifier: ServantTableViewCell.identifier)
        tableView.register(ServantTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: ServantTableViewHeaderView.identifier)

        setupSearchViewController()
    }

    // MARK:- UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering() ? 1 : Constants.servantClasses.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredServants.count
        }
        else {
            let servantClass = Constants.servantClasses[section]
            return servantsDict[servantClass]?.count ?? 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServantTableViewCell.identifier, for: indexPath) as! ServantTableViewCell

        if isFiltering() {
            cell.avatar = UIImage(named: "Servant_\(filteredServants[indexPath.row].id)")
            cell.title = filteredServants[indexPath.row].name
            return cell
        }
        else {
            let servantClass = Constants.servantClasses[indexPath.section]
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

        let servantClass = Constants.servantClasses[section]
        if let hasServant = servantsDict[servantClass], hasServant.isEmpty {
            return nil
        }

        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ServantTableViewHeaderView.identifier) as! ServantTableViewHeaderView

        headerView.title = servantClass.description()
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37.5
    }

    // MARK:- UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering() {
            let vc = ServantDetailTableViewController(servant: filteredServants[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let servantClass = Constants.servantClasses[indexPath.section]

            let vc = ServantDetailTableViewController(servant: servantsDict[servantClass]![indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }


    }

    private func setupSearchViewController() {
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.placeHolder

        searchController.searchBar.scopeButtonTitles = [
            Constants.idName, Constants.atkDesc, Constants.hpDesc, Constants.giftFromEvent
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

    private func filterContentForSearchText(_ searchText: String, scope: String = Constants.idName) {
        filteredServants = servants.filter { servant in
            if searchText == "" {
                return true
            }
            return servant.name.lowercased().contains(searchText.lowercased())
        }.sorted {
            return sortHelper(lhs: $0, rhs: $1, scope: scope)
        }

        if scope == Constants.giftFromEvent {
            filteredServants = filteredServants.filter { $0.giftFromEvent }
        }

        tableView.reloadData()
    }

    private func sortHelper(lhs: Servant, rhs: Servant, scope: String) -> Bool {
        switch scope {
        case Constants.idName:
            return lhs.id < rhs.id
        case Constants.atkDesc:
            return lhs.maxATK > rhs.maxATK
        case Constants.hpDesc:
            return lhs.maxHP > rhs.maxHP
        default:
            return lhs.id < rhs.id
        }
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
