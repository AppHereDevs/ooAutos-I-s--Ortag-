import UIKit

public final class ConsumptionDetailCellController {
    private let model: ConsumptionDetail
    private var cell: ConsumptionDetailCell?

    init(model: ConsumptionDetail) {
        self.model = model
    }

    func view(in tableView: UITableView) -> UITableViewCell {
        cell = tableView.dequeueReusableCell()
        cell?.display(model: model)
        return cell!
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
