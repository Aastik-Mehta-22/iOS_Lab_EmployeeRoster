
import UIKit

protocol EmployeeDetailTableViewControllerDelegate: AnyObject {
    func employeeDetailTableViewController(_ controller: EmployeeDetailTableViewController, didSave employee: Employee)
}

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var employeeTypeLabel: UILabel!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    
    
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    
    var isEditingBirthday = false{
        didSet {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    weak var delegate: EmployeeDetailTableViewControllerDelegate?
    var employee: Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        updateSaveButtonState()
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            
            dobLabel.text = employee.dateOfBirth.formatted(date: .abbreviated, time: .omitted)
            dobLabel.textColor = .label
            employeeTypeLabel.text = employee.employeeType.description
            employeeTypeLabel.textColor = .label
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    private func updateSaveButtonState() {
        let shouldEnableSaveButton = nameTextField.text?.isEmpty == false
        saveBarButtonItem.isEnabled = shouldEnableSaveButton
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else {
            return
        }
        
        let employee = Employee(name: name, dateOfBirth: dobDatePicker.date, employeeType: .exempt)
        delegate?.employeeDetailTableViewController(self, didSave: employee)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
    }

    @IBAction func nameTextFieldDidChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
     
        
        if indexPath.row == 2 && !isEditingBirthday {
            
        
            return 0
        } else if indexPath.row == 2 && isEditingBirthday {
            return 200
        }
        
        
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        if indexPath.row == 1 {
            
            isEditingBirthday.toggle()
            
            if isEditingBirthday {
                dobLabel.textColor = .systemBlue
            }
            else {
                dobLabel.textColor = .label
            }
            
            dobLabel.text = dobDatePicker.date.formatted(.dateTime.day().month().year())
        }
    }
    
    @IBAction func dobactionChanged(_ sender: UIDatePicker) {
        
        dobLabel.text = dobDatePicker.date.formatted(.dateTime.day().month().year())
        
    }
    

}
