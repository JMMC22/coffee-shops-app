//
//  LocationManagerStub.swift
//  CoffeeShopsAppTests
//
//  Created by José María Márquez Crespo on 2/8/24.
//

import Foundation
@testable import CoffeeShopsApp
import CoreLocation
import Combine

class LocationManagerStub: LocationManager {

    let status = PassthroughSubject<CLAuthorizationStatus, Never>()
    let lastLocation = PassthroughSubject<CLLocationCoordinate2D, Never>()

    var statusPublisher: AnyPublisher<CLAuthorizationStatus, Never> {
        status.eraseToAnyPublisher()
    }
    var lastLocationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> {
        lastLocation.eraseToAnyPublisher()
    }

    let predefinedStatus: CLAuthorizationStatus?
    let predefinedLocation: CLLocationCoordinate2D?
    let distanceToReturn: Double = 0.0

    init(predefinedStatus: CLAuthorizationStatus? = .authorizedAlways,
         predefinedLocation: CLLocationCoordinate2D? = CLLocationCoordinate2D(latitude: 40.416, longitude: -3.70)) {
        self.predefinedStatus = predefinedStatus
        self.predefinedLocation = predefinedLocation
    }

    func requestLocationPermissions() {
        if let status = predefinedStatus {
            self.status.send(status)
        }
    }

    func requestLocation() {
        if let location = predefinedLocation {
            self.lastLocation.send(location)
        }
    }

    func getDistance(to latitude: Double, longitude: Double) -> Double {
        distanceToReturn
    }
}
