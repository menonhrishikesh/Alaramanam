//
//  AddAlarmViewController.swift
//  Alaramanam
//
//  Created by Hrishikesh Menon V K on 18/06/21.
//

import UIKit

class AddAlarmViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var repeatSwitch: UISwitch!
    @IBOutlet weak var repeatStackView: UIStackView!
    @IBOutlet weak var repeatModeField: UITextField!
    
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
        self.setupFields()
        self.setupInputViews()
        self.setupNavigationButton()
    }
    
    private func setupFields() {
        if mode == .read {
            self.nameField.isEnabled            = false
            self.dateField.isEnabled            = false
            self.descriptionField.isEditable    = false
            self.repeatSwitch.isEnabled         = false
            self.repeatModeField.isEnabled      = false
        } else {
            self.nameField.isEnabled            = true
            self.dateField.isEnabled            = true
            self.descriptionField.isEditable    = true
            self.repeatSwitch.isEnabled         = true
            self.repeatModeField.isEnabled      = true
        }
        
        if let model = self.currentAlarm {
            self.nameField.text             = model.name
            self.dateField.text             = DateHelper.returnString(for: model.date, in: .ddMMMyyyyhhmma)
            self.descriptionField.text      = model.alarmDesc
            self.repeatStackView.isHidden   = !model.repeatable
            self.repeatModeField.text       = model.repeatHours.returnString()
            self.repeatSwitch.setOn(model.repeatable, animated: false)
        }
    }
    
    private func setupInputViews() {
        
        self.dateField.inputView = CustomDatePicker.instanceFromNib(onSelectingDate: { (date) in
            self.selectedDate   = date
            self.dateField.text = DateHelper.returnString(for: date, in: .ddMMMyyyyhhmma)
            self.dateField.resignFirstResponder()
        })
        
        self.descriptionField.inputAccessoryView = DoneButtonAccessoryView.instanceFromNib {
            self.descriptionField.resignFirstResponder()
        }
        
        self.repeatModeField.inputView = CustomPickerView.instanceFromNib(items: AlarmRepeatTime.returnCaseStrings(), onDoneAction: { (string) in
            self.repeatModeField.text = string
            self.repeatModeField.resignFirstResponder()
        })
    }
    
    private func setupNavigationButton() {
        self.navigationItem.rightBarButtonItem = nil
        let button          = UIBarButtonItem(barButtonSystemItem: self.mode.returnNavButtonStyle(), target: self, action: #selector(doneAction(_:)))
        button.tintColor    = .label
        button.style        = .done
        self.navigationItem.rightBarButtonItem = button
    }
    
    private func setAlarm(for date: Date) {
        let alarm = Alarm(name: self.nameField.text ?? "Alarm @ \(String(describing: dateField.text))", date: date, repeatable: self.repeatSwitch.isOn, repeatHours: .daily)
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
        UIView.animate(withDuration: 0.2) {
            self.repeatStackView.isHidden = !self.repeatSwitch.isOn
        }
    }
}

extension AddAlarmViewController: UITextFieldDelegate, UITextViewDelegate {
    //MARK:- TextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.scrollView.setContentOffset(CGPoint(x: 0, y: textField.frame.origin.y), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.scrollView.setContentOffset(.zero, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    //MARK:- TextView Delegates
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.scrollView.setContentOffset(CGPoint(x: 0, y: textView.frame.origin.y + textView.frame.height), animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.scrollView.setContentOffset(.zero, animated: true)
    }
}
