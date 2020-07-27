//
//  MainViewController.swift
//  RyanairMobileTest
//
//  Created by degomos on 26/07/2020.
//  Copyright © 2020 degomos. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, StationViewDelegate, FlyOutViewDelegate, PassengerViewDelegate, SelectionListViewControllerDelegate, CalenderViewControllerDelegate, PassengerViewControllerDelegate {
    
    @IBOutlet weak var btnSearchFlights: UIButton!
    @IBOutlet weak var stackViewMain: UIStackView!
    
    let stationView = StationView()
    let flyOutView = FlyOutView()
    let passengersView = PassengersView()
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isStationEmpty()
    }
    //Configure button with initial values
    func configureUI() {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let txt = NSMutableAttributedString(string: "SEARCH_FLIGHTS".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: CGFloat(GENK.txtSize.sMediumPlus))])
        btnSearchFlights.backgroundColor = UIColor.blue
        btnSearchFlights.layer.cornerRadius = 5
        btnSearchFlights.setAttributedTitle(txt, for: .normal)
    }
    //Setup all the view in the main view controller with data
    func setViewWithData() {
        let defaultTo = StationsItemDataModel(json: ["code": "DEFAULT_TO_COUNTRY_NAME".localized, "countryName": "DEFAULT_TO_COUNTRY_NAME".localized])
        let defaultFrom = StationsItemDataModel(json: ["code": "DEFAULT_FROM_CODE".localized, "countryName": "DEFAULT_FROM_COUNTRY_NAME".localized])
        
        stationView.delegate = self
        stationView.updateFromInfo = defaultFrom
        stationView.updateToInfo = defaultTo
        
        flyOutView.delegate = self
        flyOutView.updateFlyOutDate = "FLY_OUT".localized
        
        passengersView.delegate = self
        passengersView.updatePassengerInfo = "PASSENGERS".localized
        
        stackViewMain.addArrangedSubview(stationView)
        stackViewMain.addArrangedSubview(flyOutView)
        stackViewMain.addArrangedSubview(passengersView)
    }
    //Check if stationList array is empty
    func isStationEmpty() {
        if appdelegate.stationsList.isEmpty {
            getStations()
        }
    }
    //Resquest all stations
    func getStations() {
        Networking().getStations { (responseObject) in
            for st in responseObject!.stations {
                let _st = StationsItemDataModel(json: st)
                self.appdelegate.stationsList.append(_st)
            }
            self.setViewWithData()
        }
    }
    //Present viewcontroller with list of stations
    func listStation(selectedStation: SelectedStation) {
        Utils.selectionListViewController(selectedStation: selectedStation, viewController: self)
    }
    //Present viewController with calendar
    func flyOutDate() {
        Utils.calendarViewController(viewController: self)
    }
    //Present viewController with passenger
    func passengers() {
        Utils.passengerViewController(viewController: self)
    }
    //Callback from viewcontroller with list of stations
    func didTapTableView(selectedCode: String, selectedStation: SelectedStation) {
        let st = setSelectedStation(code: selectedCode)
        switch selectedStation {
        case .from:
            stationView.updateFromInfo = st
            appdelegate.stFrom = st.code
            break
        case .to:
            stationView.updateToInfo = st
            appdelegate.stTo = st.code
            break
        }
    }
    //Fetch current selected station from list of stations
    func setSelectedStation(code: String) -> StationsItemDataModel {
        let filteredStations = appdelegate.stationsList.filter({ (station: StationsItemDataModel) -> Bool in
            return station.code.lowercased().contains(code.lowercased())
        })
        
        return filteredStations[0]
    }
    //Callback from viewcontroller with calendar
    func exitCalendarView(currentYear: Int, currentMonth: Int, currentDay: Int) {
        let selectedDate =  "\(currentYear)-\(currentMonth)-\(currentDay)"
        appdelegate.selectionDate = selectedDate
        flyOutView.updateFlyOutDate = selectedDate
    }
    //Callback from viewController with passenger selection
    func passenger(adt: Int, teen: Int, chd: Int) {
        var selectPassengers = "\(adt) " + "ADULTS".localized
        appdelegate.adt = adt
        if teen > 0 {
            selectPassengers += ", \(teen) " + "TEENS".localized
            appdelegate.teen = teen
        }
        if chd > 0 {
            selectPassengers += ", \(chd) " + "CHILDREN".localized
            appdelegate.chd = chd
        }
        passengersView.updatePassengerInfo = selectPassengers
    }
    //Resquest flights availability
    @IBAction func btnSearchFlightsTapped(_ sender: UIButton) {
        Networking().getSearchResult(origin: appdelegate.stFrom, destination: appdelegate.stTo, dateout: appdelegate.selectionDate, adt: "\(appdelegate.adt)", teen: "\(appdelegate.teen)", chd: "\(appdelegate.chd)") { (responseObject) in
            if let searchList = responseObject!.searchList.first {
                if let dates: [NSDictionary] = searchList["dates"] as? [NSDictionary] {
                    var checkIfExistFlights = false
                    self.appdelegate.flights.removeAll()
                    for fts in dates {
                        for ft in fts["flights"] as! NSArray {
                            checkIfExistFlights = true
                            let flight = FlightsDataModel(json: ft as! NSDictionary)
                            self.appdelegate.flights.append(flight)
                        }
                    }
                    if checkIfExistFlights {
                        Utils.ResultListViewController(viewController: self)
                    } else {
                        ShowAlert.show(title: "WARNING".localized, message: "ERROR_TRIP".localized, vc: self)
                    }
                } else {
                    
                }
            } else {
                ShowAlert.show(title: "WARNING".localized, message: "ERROR_TRIP".localized, vc: self)
            }
        }
    }
}
