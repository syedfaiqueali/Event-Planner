import UIKit

class FoodAndDrinksViewCell: UITableViewCell {
    
    @IBOutlet weak var foodAndDrinksNameLabel: UILabel!
    @IBOutlet weak var foodAndDrinksPriceLabel: UILabel!
    @IBOutlet weak var foodAndDrinksImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
