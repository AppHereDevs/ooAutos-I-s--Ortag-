import UIKit

public final class ConsumptionDetailCell: UITableViewCell {
    @IBOutlet var plateNumberLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var serviceNameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!

    func display(model: ConsumptionDetail) {
        plateNumberLabel.text = model.plateNumber
        dateLabel.text = model.consumeDate
        serviceNameLabel.text = model.serviceName
        priceLabel.text = model.price
        timeLabel.text = model.consumeTime
    }
}
