//
//  CoworkingSpaceDetailsViewModel.swift
//  CoworkingApp
//
//  Created by José María Márquez Crespo on 31/3/24.
//

import Foundation
import CoreLocation
import MapKit

class CoworkingSpaceDetailsViewModel: ObservableObject {

    @Published var name: String = ""
    @Published var address: String = ""
    @Published var isOpenNow: Bool = false
    @Published var coordinate: MKCoordinateRegion = .init()
    @Published var isFavourite: Bool = false
    @Published var imagesURLs: [URL?] = []
    @Published var schedule: String = ""
    @Published var distance: String = ""

    @Published var isLoading: Bool = true
    @Published var error: RequestError?

    // MARK: External
    var coffeeURL: URL?
    var phoneNumber: String = ""

    private let getCoworkingSpaceDetails: GetCoworkingSpaceDetails
    private let updateFavouriteCoworkingSpace: UpdateFavouriteCoworkingSpace
    private let isFavouriteCoworkingSpace: IsFavouriteCoworkingSpace
    private let locationManager: LocationManager

    private let id: String
    private var coworkingSpace: Place?

    init(_ id: String, 
         getCoworkingSpaceDetails: GetCoworkingSpaceDetails,
         updateFavouriteCoworkingSpace: UpdateFavouriteCoworkingSpace,
         isFavouriteCoworkingSpace: IsFavouriteCoworkingSpace,
         locationManager: LocationManager = DefaultLocationManager.shared) {
        self.id = id
        self.getCoworkingSpaceDetails = getCoworkingSpaceDetails
        self.updateFavouriteCoworkingSpace = updateFavouriteCoworkingSpace
        self.isFavouriteCoworkingSpace = isFavouriteCoworkingSpace
        self.locationManager = locationManager
    }
}

extension CoworkingSpaceDetailsViewModel {

    func getCoworkingSpaceDetails() async {
        let result = await getCoworkingSpaceDetails.execute(id: id)

        switch result {
        case .success(let coworkingSpace):
            getCoworkingSpaceDetailsDidSuccess(coworkingSpace)
        case .failure(let error):
            getCoworkingSpaceDetailsDidFail(error)
        }
    }

    private func getCoworkingSpaceDetailsDidSuccess(_ coworkingSpace: Place) {
        self.coworkingSpace = coworkingSpace
        let isFavourite = isFavouriteCoworkingSpace.execute(id: coworkingSpace.id)

        DispatchQueue.main.async {
            self.name = coworkingSpace.name
            self.address = coworkingSpace.address
            self.isOpenNow = coworkingSpace.isOpen
            self.coordinate = self.createCoordinateRegion(coworkingSpace.coordinate)
            self.imagesURLs = coworkingSpace.photos.map({ $0.getPlacePhotoURL() })
            self.coffeeURL = coworkingSpace.url
            self.phoneNumber = coworkingSpace.phoneNumber
            self.schedule = coworkingSpace.formattedSchedule
            self.isFavourite = isFavourite
            self.distance = self.getDistance(coworkingSpace.coordinate)
            self.isLoading = false
        }
    }

    private func getCoworkingSpaceDetailsDidFail(_ error: RequestError) {
        DispatchQueue.main.async {
            self.error = error
            self.isLoading = false
        }
    }
}

extension CoworkingSpaceDetailsViewModel {

    func saveAsFavourite() {
        guard var coworkingSpace else { return }

        coworkingSpace.isFavourite = !isFavourite
        let result = updateFavouriteCoworkingSpace.execute(coworkingSpace)

        switch result {
        case .success(let value):
            saveAsFavouriteDidSuccess(value: value)
        case .failure(let error):
            saveAsFavouriteDidFail(error)
        }
    }

    private func saveAsFavouriteDidSuccess(value: Bool) {
        DispatchQueue.main.async {
            self.isFavourite = value
        }
    }

    private func saveAsFavouriteDidFail(_ error: RequestError) {
        print("||DEBUG|| saveAsFavouriteDidFail - error: \(error.localizedDescription)")
    }
}

extension CoworkingSpaceDetailsViewModel {

    private func getDistance(_ coordinates: CLLocationCoordinate2D) -> String {
        let distanceToPlace = locationManager.getDistance(to: coordinates.latitude, longitude: coordinates.longitude)
        return getFormattedDistance(distanceToPlace)
    }

    private func getFormattedDistance(_ distance: Double) -> String {
        return distance < 1000 ? getMeters(distance) : getKilometers(distance)
    }

    private func getMeters(_ distance: Double) -> String {
        return "\(Int(distance)) m"
    }

    private func getKilometers(_ distance: Double) -> String {
        return String(format: "%.1f km", (distance / 1000))
    }

    private func createCoordinateRegion(_ coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        MKCoordinateRegion(center: coordinate,
                           span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }

    func getMapAppURL(_ app: MapApp) -> URL? {
        return URL(string: app.appUrl(latitude: coworkingSpace?.coordinate.latitude,
                                      longitude: coworkingSpace?.coordinate.longitude))
    }
}
