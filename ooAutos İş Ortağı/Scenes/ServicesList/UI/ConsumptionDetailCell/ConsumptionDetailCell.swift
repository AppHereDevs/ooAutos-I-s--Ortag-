import UIKit
import AppHereComponents

public final class ConsumptionDetailCell: UITableViewCell {
    @IBOutlet weak var plateNumberLabel: AppHereLabel!
    @IBOutlet weak var dateLabel: AppHereLabel!
    @IBOutlet weak var serviceNameLabel: AppHereLabel!
    @IBOutlet weak var priceLabel: AppHereLabel!
    @IBOutlet weak var timeLabel: AppHereLabel!

    func display(model: ConsumptionDetail) {
        plateNumberLabel.text = model.plateNumber
        dateLabel.text = model.consumeDate
        serviceNameLabel.text = model.serviceName
        priceLabel.text = model.price
        timeLabel.text = model.consumeTime
    }
}
