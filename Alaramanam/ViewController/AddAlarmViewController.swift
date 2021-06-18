//
//  AddAlarmViewController.swift
//  Alaramanam
//
//  Created by Hrishikesh Menon V K on 18/06/21.
//

import UIKit

class AddAlarmViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var repeatSwitch: UISwitch!
    @IBOutlet weak var repeatStackView: UIStackView!
    @IBOutlet weak var repeatModeButton: UIButton!
    
    enum ViewMode {
        case create
        case read
        case edit
        
        func returnNavButtonStyle() -> UIBarButtonItem.SystemItem {
            if self == .read {
                return .edit
            }
            return .done
        }
    }
    
    var mode: ViewMode = .create
    var currentAlarm: Alarm?
    var onAddingAlarm: AlarmPasser?
    
    var selectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        if mode == .read {
            self.nameField.isEnabled            = false
            self.dateField.isEnabled            = false
            self.descriptionField.isEditable    = false
            self.repeatSwitch.isEnabled         = false
            self.repeatModeButton.isEnabled     = false
        } else {
            self.nameField.isEnabled            = true
            self.dateField.isEnabled            = true
            self.descriptionField.isEditable    = true
            self.repeatSwitch.isEnabled         = true
            self.repeatModeButton.isEnabled     = true
        }
        
        self.updateDoneButton()
        
        if let model = self.currentAlarm {
            self.nameField.text = model.name
            self.dateField.text = DateHelper.returnString(for: model.date, in: .dateMonthTime)
            self.descriptionField.text  = model.alarmDesc
            self.repeatSwitch.setOn(model.repeatable, animated: false)
            self.repeatStackView.isHidden = !self.repeatSwitch.isOn
            self.repeatModeButton.setTitle(model.repeatHours.returnString(), for: self.repeatModeButton.state)
        }
    }
    
    private func updateDoneButton() {
        self.navigationItem.rightBarButtonItem = nil
        let button          = UIBarButtonItem(barButtonSystemItem: self.mode.returnNavButtonStyle(), target: self, action: #selector(doneAction(_:)))
        button.tintColor    = .label
        button.style        = .done
        self.navigationItem.rightBarButtonItem = button
    }
    
    private func setAlarm(for date: Date) {
        let alarm = Alarm(name: self.nameField.text ?? "Alarm @ \(String(describing: dateField.text))", date: date, repeatable: self.repeatSwitch.isOn, repeatHours: .none)
        self.onAddingAlarm?(alarm)
        self.backAction(self)
    }
    
    
    //MARK:- Button Actions
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        if self.mode == .read {
            self.mode = .edit
            self.setupUI()
        } else {
            self.selectedDate = Date()
            if let date = self.selectedDate {
                self.setAlarm(for: date)
            } else {
                AlertHelper.showAlert(title: "Enter Date", message: nil, actions: [UIAlertAction(title: "OK", style: .cancel, handler: nil)], viewController: self)
            }
        }
    }
    
    @IBAction func repeatSwitchAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.repeatStackView.isHidden = !self.repeatSwitch.isOn
        }
    }
    
    @IBAction func repeatModeAction(_ sender: Any) {
        
    }
    
}

extension AddAlarmViewController: UITextFieldDelegate {
    
}
