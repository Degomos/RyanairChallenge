//
//  SelectionListViewController.swift
//  RyanairMobileTest
//
//  Created by degomos on 26/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import UIKit

protocol SelectionListViewControllerDelegate {
    func didTapTableView(selectedCode: String, selectedStation: SelectedStation)
}

class SelectionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableViewSelectionList: UITableView!
    
    let reuseIdentifier = "SelectionTableViewCell"
    var delegate: SelectionListViewControllerDelegate?
    var selectedStation: SelectedStation!
    var filteredStations = [StationsItemDataModel]()
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    //Configure tableview, searchBar and station list
    func configure() {
        tableViewSelectionList.dataSource = self
        tableViewSelectionList.delegate = self
        tableViewSelectionList.separatorStyle = .singleLine
        searchBar.delegate = self
        searchBar.placeholder = "SEARCHBAR_PLACEHOLDER".localized
        searchBar.searchBarStyle = .prominent
        
        filteredStations = appDelegate.stationsList
    }
    //Filter search stations
    func filteredContentForSearchText(searchText: String) {
        filteredStations = appDelegate.stationsList.filter({ (station: StationsItemDataModel) -> Bool in
            if searchBarEmpty() {
                return true
            } else {
                return station.code.lowercased().contains(searchText.lowercased()) || station.countryName.lowercased().contains(searchText.lowercased())
            }
        })
        
        tableViewSelectionList.reloadData()
    }
    //Check is searchBar text is empty
    func searchBarEmpty() -> Bool {
        return searchBar.text?.isEmpty ?? true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let selectionResult = filteredStations[indexPath.row]
        let cell = tableViewSelectionList.dequeueReusableCell(withIdentifier: reuseIdentifier) as! SelectionTableViewCell
        cell.selectionStyle = .gray
        cell.setUpTableViewCell(data: selectionResult)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didTapTableView(selectedCode: filteredStations[indexPath.row].code, selectedStation: selectedStation)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredContentForSearchText(searchText: searchText)
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}
