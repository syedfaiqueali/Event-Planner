import UIKit

protocol EventFoodAndDrinksDetailsPassing {
    func passFoodAndDrinksDetails(noOfSelectedItems: Int, totalCost: Int, selectedItems: [String])
}

class EventFoodAndDrinksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noOfPersonsLabel: UILabel!
    @IBOutlet weak var selectedItemsLabel: UILabel!
    @IBOutlet weak var foodCostLabel: UILabel!
    
    
    var foodAndDrinksName = ["Burger", "Cold drinks", "Snacks", "Tea or Coffee", "Briyani", "Pasta", "Spagetties"]
    var foodAndDrinksPrice: [Int] = [30,40,50,60,70,80,100]
    var selectedFoodAndDrinksNames = [String]()
    var selectedFoodAndDrinksPrices = [Int]()
    var totalFoodAndDrinksCost = 0
    var noOfPersons: Int = 0
    
    var delegate: EventFoodAndDrinksDetailsPassing?

    override func viewDidLoad() {
        super.viewDidLoad()

        noOfPersonsLabel.text = String(noOfPersons)
        
        self.tableView.isEditing = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
    }
    
    func selectDeselectCell(tableView: UITableView, indexPath: IndexPath) {
        
        self.selectedFoodAndDrinksNames.removeAll()
        self.selectedFoodAndDrinksPrices.removeAll()
        if let arr = tableView.indexPathsForSelectedRows {
            for index in arr {
                selectedFoodAndDrinksNames.append(foodAndDrinksName[index.row])
                selectedFoodAndDrinksPrices.append(foodAndDrinksPrice[index.row])
            }
        }
        print(selectedFoodAndDrinksNames)
        print(selectedFoodAndDrinksPrices)
        
        selectedItemsLabel.text = String(selectedFoodAndDrinksNames.count)
        
        calculateCost(selectedSnack: selectedFoodAndDrinksPrices)
    }
    
    func calculateCost(selectedSnack: [Int]) {
        self.totalFoodAndDrinksCost = 0
        for cost in 0..<selectedSnack.count {
            totalFoodAndDrinksCost = totalFoodAndDrinksCost + (selectedSnack[cost] * noOfPersons )
        }
        foodCostLabel.text = String(totalFoodAndDrinksCost)
    }
    
    
    //MARK:- Action
    @IBAction func done(){
        delegate?.passFoodAndDrinksDetails(noOfSelectedItems: selectedFoodAndDrinksNames.count, totalCost: totalFoodAndDrinksCost, selectedItems: selectedFoodAndDrinksNames)
        
        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

extension EventFoodAndDrinksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodAndDrinksName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SnackCell") as! FoodAndDrinksViewCell
        
        cell.foodAndDrinksNameLabel.text! = foodAndDrinksName[indexPath.row]
        cell.foodAndDrinksPriceLabel.text = String(foodAndDrinksPrice[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectDeselectCell(tableView: tableView, indexPath: indexPath)
        
        print("select")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.selectDeselectCell(tableView: tableView, indexPath: indexPath)
        print("deselect")
    }
    
}
