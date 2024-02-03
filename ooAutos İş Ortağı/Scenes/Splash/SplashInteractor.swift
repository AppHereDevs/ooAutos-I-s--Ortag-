//
//  SplashInteractor.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 13.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SplashBusinessLogic {}

protocol SplashDataStore {}

class SplashInteractor: SplashBusinessLogic, SplashDataStore {
    // MARK: - Properties

    lazy var worker = SplashWorker()
    var presenter: SplashPresentationLogic?
}
