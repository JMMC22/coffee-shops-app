//
//  LocationManager.swift
//  CoffeeShopsApp
//
//  Created by José María Márquez Crespo on 2/5/24.
//

import Foundation
import CoreLocation
import Combine

protocol LocationManager {
    var status: PassthroughSubject<CLAuthorizationStatus, Never> { get }
    var lastLocation: PassthroughSubject<CLLocationCoordinate2D, Never> { get }
    var statusPublisher: AnyPublisher<CLAuthorizationStatus, Never> { get }
    var lastLocationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> { get }

    func requestLocationPermissions()
    func requestLocation()
    func getDistance(to latitude: Double, longitude: Double) -> Double
}

class DefaultLocationManager: NSObject, ObservableObject, LocationManager {

    internal let status = PassthroughSubject<CLAuthorizationStatus, Never>()
    internal let lastLocation = PassthroughSubject<CLLocationCoordinate2D, Never>()

    var statusPublisher: AnyPublisher<CLAuthorizationStatus, Never> {
        status.eraseToAnyPublisher()
    }

    var lastLocationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> {
        lastLocation.eraseToAnyPublisher()
    }

    private var lastUserLocation: CLLocationCoordinate2D = .init()

    static let shared = DefaultLocationManager()

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
        locationManager.requestLocation()
    }

    func getDistance(to latitude: Double, longitude: Double) -> Double {
        let sourceLocation = CLLocation(latitude: lastUserLocation.latitude, longitude: lastUserLocation.longitude)
        let destinationLocation = CLLocation(latitude: latitude, longitude: longitude)

        return sourceLocation.distance(from: destinationLocation)
    }
}

extension DefaultLocationManager: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        status.send(manager.authorizationStatus)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else { return }
        lastUserLocation = location
        lastLocation.send(location)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("||ERROR|| locationManager: \(error.localizedDescription)")
    }
}
