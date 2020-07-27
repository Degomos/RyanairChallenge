//
//  ResultViewController.swift
//  RyanairMobileTest
//
//  Created by degomos on 27/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//
import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewSelectionList: UITableView!
    
    let reuseIdentifier = "ResultTableViewCell"
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    //configure table view
    func configure() {
        tableViewSelectionList.dataSource = self
        tableViewSelectionList.delegate = self
        tableViewSelectionList.separatorStyle = .singleLine
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fares = appDelegate.flights[indexPath.row].regularFare["fares"] as! NSArray
        let selectionResult = RegularFareDataModel(json: fares.firstObject as! NSDictionary)
        
        let cell = tableViewSelectionList.dequeueReusableCell(withIdentifier: reuseIdentifier) as! ResultTableViewCell
        cell.selectionStyle = .gray
        cell.setUpTableViewCell(data: selectionResult, date: appDelegate.flights[indexPath.row].timeUTC.first!, flightNumber: appDelegate.flights[indexPath.row].flightNumber)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
}

