import AppHereComponents
import UIKit

public final class ConsumptionDetailCell: UITableViewCell {
    @IBOutlet var plateNumberLabel: AppHereLabel!
    @IBOutlet var dateLabel: AppHereLabel!
    @IBOutlet var serviceNameLabel: AppHereLabel!
    @IBOutlet var priceLabel: AppHereLabel!
    @IBOutlet var timeLabel: AppHereLabel!

    func display(model: ConsumptionDetail) {
        plateNumberLabel.text = model.plateNumber
        dateLabel.text = model.consumeDate
        serviceNameLabel.text = model.serviceName
        priceLabel.text = model.price
        timeLabel.text = model.consumeTime
    }
}
