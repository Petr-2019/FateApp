//
//  MasterEquipmentVC.swift
//  FateIndex
//
//  Created by Peter-Guan on 2020/4/17.
//  Copyright © 2020 管君. All rights reserved.
//

import UIKit

class MasterEquipmentVC: UITableViewController {

    private struct Constants {
        static let defaultCellHeight: CGFloat = 78.0

        static let placeHolder = "搜索魔术礼装"
    }

    private let searchController = UISearchController(searchResultsController: nil)

    private var masterEquipments = [MasterEquipment]()

    private lazy var equipmentsDict = {
        return Dictionary(grouping: masterEquipments, by: { $0.name })
    }()

    private var filteredMasterEquipments = [MasterEquipment]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(AvatarWithTextTableViewCell.self, forCellReuseIdentifier: AvatarWithTextTableViewCell.identifier)
        tableView.register(TableViewTitleHeaderView.self, forHeaderFooterViewReuseIdentifier: TableViewTitleHeaderView.identifier)

        setupSearchViewController()
        masterEquipments = MasterEquipmentManager.shared.allMasterEquipments()
    }

    // MARK:- UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMasterEquipments.count
        }
        else {
            return masterEquipments.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AvatarWithTextTableViewCell.identifier, for: indexPath) as! AvatarWithTextTableViewCell

        cell.accessoryType = .disclosureIndicator

        if isFiltering() {
            let avatarName = "Master_Equip_\(indexPath.row + 1)a"
            cell.avatar = UIImage(named: avatarName)
            cell.title = filteredMasterEquipments[indexPath.row].name
            return cell
        }
        else {
            let avatarName = "Master_Equip_\(indexPath.row + 1)a"
            cell.avatar = UIImage(named: avatarName)
            cell.title = masterEquipments[indexPath.row].name
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.defaultCellHeight
    }

    // MARK:- UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltering() {
            let vc = MasterEquipmentDetailVC(masterEquipment: filteredMasterEquipments[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = MasterEquipmentDetailVC(masterEquipment: masterEquipments[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    private func setupSearchViewController() {
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.placeHolder
        searchController.searchBar.delegate = self

        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}

extension MasterEquipmentVC: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    private func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }

    private func filterContentForSearchText(_ searchText: String) {
        filteredMasterEquipments = masterEquipments.filter { masterEquipment in
            if searchText == "" {
                return true
            }
            return masterEquipment.name.lowercased().contains(searchText.lowercased())
        }

        tableView.reloadData()
    }

    private func isFiltering() -> Bool {
      let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
      return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
    }

}

extension MasterEquipmentVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
        searchBar.resignFirstResponder()
    }

}
