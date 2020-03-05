import UIKit

class MyEventViewCell: UITableViewCell {
    
    @IBOutlet weak var myEventImageView: UIImageView!
    @IBOutlet weak var myEventNameLabel: UILabel!
    @IBOutlet weak var myEventTimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(for event: Event) {
        myEventNameLabel.text = event.e_name
        myEventTimeLabel.text = event.e_date
        myEventImageView.image = UIImage(data: event.e_venue_image)
    }

}
