//
//  ServicesListInteractor.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ServicesListBusinessLogic: AnyObject {
}

protocol ServicesListDataStore {}

class ServicesListInteractor: ServicesListBusinessLogic, ServicesListDataStore {

    // MARK: - Properties

    var worker: ServicesListWorkerLogic?
    var presenter: ServicesListPresentationLogic?

}
