//
//  ServicesListViewController.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

public final class ServicesListViewController: UIViewController {
    // MARK: - Properties
    var router: ServicesListRoutingLogic?
    private var  interactor: ServicesListBusinessLogic?

    @IBOutlet weak var tableView: UITableView!
    
    private let loadingIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    var tableModel = [ConsumptionDetailCellController]() {
        didSet {
            tableView.reloadData()
            hideLoadingIndicator(loadingIndicator: loadingIndicator)
        }
    }

    // MARK: - Object lifecycle

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError()
    }
    
    init() {
        super.init(nibName: nil, bundle: .main)
    }
    
    public convenience init(interactor: ServicesListBusinessLogic) {
        self.init()
        self.interactor = interactor
    }

    // MARK: - View Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ConsumptionDetailCell", bundle: nil), forCellReuseIdentifier: "ConsumptionDetailCell")

        loadingIndicator.color = .white
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)

        setupBackgroundImage(imageName: "background")
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        interactor?.getConsumptionDetail(startDate: nil, endDate: nil)
        showLoadingIndicator(loadingIndicator: loadingIndicator)
    }

    @IBAction func filterButtonPressed(_ sender: Any) {

    }
}

extension ServicesListViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellController(forRowAt: indexPath).view(in: tableView)
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 1
        return cell
    }

    private func cellController(forRowAt indexPath: IndexPath) -> ConsumptionDetailCellController {
        return tableModel[indexPath.row]
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87
    }

    // Set the spacing between sections
    public func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 }
        return 8
    }

    public func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        1
    }

    public func numberOfSections(in _: UITableView) -> Int {
        return tableModel.count
    }
}
