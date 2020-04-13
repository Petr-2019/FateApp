//
//  EmblemTableViewController.swift
//  FateIndex+
//
//  Created by PeterGuan on 2019/10/6.
//  Copyright © 2019 管君. All rights reserved.
//

import UIKit

class EmblemTableViewController: UITableViewController {

    private struct Constants {
        static let defaultCellHeight: CGFloat = 78.0

        static let rare: [String] = [
            "⭐", "⭐⭐", "⭐⭐⭐", "⭐⭐⭐⭐",
            "⭐⭐⭐⭐⭐"
        ]

        static let placeHolder = "搜索指令纹章"
        static let idName = "编号"
    }

    private let searchController = UISearchController(searchResultsController: nil)

    private var emblems = EmblemManager.shared.allEmblems()

    private lazy var emblemsDict = {
        return Dictionary(grouping: emblems, by: { $0.rare })
    }()

    private var filteredEmblems = [Emblem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(AvatarWithTextTableViewCell.self, forCellReuseIdentifier: AvatarWithTextTableViewCell.identifier)
        tableView.register(TableViewTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: TableViewTitleHeaderView.identifier)

        setupSearchViewController()
    }

    // MARK:- UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering() ? 1 : Constants.rare.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredEmblems.count
        }
        else {
            let rare = Constants.rare[section]
            return emblemsDict[rare]?.count ?? 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

        cell.accessoryType = .disclosureIndicator

        if isFiltering() {
            cell.avatar = UIImage(named: "Emblem_\(filteredEmblems[indexPath.row].id)")
            cell.title = filteredEmblems[indexPath.row].name
            return cell
        }
        else {
            let rare = Constants.rare[indexPath.section]
            cell.avatar = UIImage(named: "Emblem_\(emblemsDict[rare]![indexPath.row].id)")
            cell.title = emblemsDict[rare]?[indexPath.row].name
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

        let rare = Constants.rare[section]
        if let hasEmblem = emblemsDict[rare], hasEmblem.isEmpty {
            return nil
        }

        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewTitleHeaderView.identifier) as! TableViewTitleHeaderView

        headerView.title = rare

        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 37.5
    }

    // MARK:- UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering() {
            let vc = EmblemDetailViewController(emblem: emblems[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let rare = Constants.rare[indexPath.section]

            let vc = EmblemDetailViewController(emblem: emblemsDict[rare]![indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    private func setupSearchViewController() {
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.placeHolder
        searchController.searchBar.delegate = self

        searchController.searchBar.scopeButtonTitles = [
            Constants.idName
        ]
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension EmblemTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)

//        let scopes = [Constants.atkDesc, Constants.hpDesc]
//        if scopes.contains(scope) {
//            searchBar.resignFirstResponder()
//        }
    }

    private func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private func filterContentForSearchText(_ searchText: String, scope: String = Constants.idName) {
        filteredEmblems = emblems.filter { emblem in
            if searchText == "" {
                return true
            }
            return emblem.name.contains(searchText.lowercased())
        }.sorted {
            $0.name < $1.name
        }

        tableView.reloadData()
    }

    private func isFiltering() -> Bool {
      let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
      return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }

}

extension EmblemTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
        searchBar.resignFirstResponder()
    }

}
