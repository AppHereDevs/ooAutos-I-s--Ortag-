//
//  ProfileInteractor.swift
//  ooAutos İş Ortağı
//
//  Created by Muhammed Sevük on 15.12.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProfileBusinessLogic: AnyObject {
}

protocol ProfileDataStore {
}

class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {

    // MARK: - Properties

    var worker: ProfileWorkerLogic?
    var presenter: ProfilePresentationLogic?

}
