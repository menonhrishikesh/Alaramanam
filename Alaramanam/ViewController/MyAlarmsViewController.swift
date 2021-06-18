//
//  MyAlarmsViewController.swift
//  Alaramanam
//
//  Created by Hrishikesh Menon V K on 18/06/21.
//

import UIKit

class MyAlarmsViewController: UIViewController {

    @IBOutlet weak var alarmsTableView: UITableView!
    
    
    var alarms: [Alarm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.alarmsTableView.rowHeight                      = UITableView.automaticDimension
        self.alarmsTableView.estimatedRowHeight             = 50
        self.alarmsTableView.tableFooterView                = UIView(frame: .zero)
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.addAlarm.rawValue {
            let addAlarmViewController = segue.destination as! AddAlarmViewController
            if sender == nil {
                addAlarmViewController.mode = .create
            } else {
                addAlarmViewController.mode = .read
            }
            
            addAlarmViewController.onAddingAlarm = { alarm in
                self.alarms.append(alarm)
                self.alarms.sort(by: { ($0.date ?? Date()) < ($1.date ?? Date()) })
                self.alarmsTableView.reloadData()
            }
        }
    }

    //MARK:- Button Actions
    @IBAction func addButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: SegueIdentifiers.addAlarm.rawValue, sender: nil)
    }
    

}

extension MyAlarmsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAlarmCell") as! MyAlarmCell
        cell.populateMyAlarmCell(alarm: self.alarms[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if self.alarms.isEmpty {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
            footerView.backgroundColor = .clear
            let title       = UILabel()
            title.text      = "No alarms set"
            title.font      = UIFont.preferredFont(forTextStyle: .footnote)
            title.sizeToFit()
            footerView.addSubview(title)
            title.center    = footerView.center
            return footerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if self.alarms.isEmpty {
            return 30
        }
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.alarms.count > indexPath.row {
            self.performSegue(withIdentifier: SegueIdentifiers.addAlarm.rawValue, sender: self.alarms[indexPath.row])
        }
    }
    
}
