//
//  LocationManager.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 2/5/24.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {

    private let status = PassthroughSubject<CLAuthorizationStatus, Never>()
    private let lastLocation = PassthroughSubject<CLLocationCoordinate2D, Never>()

    var statusPublisher: AnyPublisher<CLAuthorizationStatus, Never> {
        status.eraseToAnyPublisher()
    }

    var lastLocationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> {
        lastLocation.eraseToAnyPublisher()
    }

    static let shared = LocationManager()

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        status.send(locationManager.authorizationStatus)
    }

    func requestLocationPermissions() {
        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        status.send(manager.authorizationStatus)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else { return }
        lastLocation.send(location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("||ERROR|| locationManager: \(error.localizedDescription)")
    }
}
