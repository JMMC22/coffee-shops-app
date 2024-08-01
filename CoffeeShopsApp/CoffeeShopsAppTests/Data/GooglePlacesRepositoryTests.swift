//
//  GooglePlacesRepositoryTests.swift
//  CoffeeShopsAppTests
//
//  Created by José María Márquez Crespo on 1/8/24.
//

import XCTest
@testable import CoffeeShopsApp

final class GooglePlacesRepositoryTests: XCTestCase {

    func test_get_nearby_places_success_return_response_when_datasource_return_response() async throws {
        // GIVEN
        let mockResponse = PlacesNearbySearchDTO.makePlacesNearbySearch()
        let result: Result<PlacesNearbySearchDTO, RequestError> = .success(mockResponse)
        let remoteStub = GooglePlacesRemoteDatasourceStub(getNearbyPlacesResult: result)
        let localStub = GooglePlacesUserDefaultsDatasourceStub()

        let sut = DefaultGooglePlacesRepository(googlePlacesRemoteDatasource: remoteStub,
                                                googlePlacesUserDefaultsDatasource: localStub)
        // WHEN
        let capturedResult = await sut.getNearbyPlaces(location: "", radius: "", keyword: "")

        // THEN
        let placesResponse = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(placesResponse, PlacesNearbySearch.makePlacesNearbySearch())
    }

}

private extension PlacesNearbySearchDTO {
    static func makePlacesNearbySearch() -> PlacesNearbySearchDTO {
        var mockArray = [
            PlaceDTO(id: "1", geometry: PlaceGeometryDTO(location: PlaceLocationDTO(latitude: 37.3318, longitude: -122.0312)),
                name: "Librería Central", openingHours: nil, photos: [], address: "123 Calle Principal, Ciudad, País",
                url: "http://libreriacentral.com", phoneNumber: "+123456789"
            ),
            PlaceDTO(id: "2", geometry: PlaceGeometryDTO(location: PlaceLocationDTO(latitude: 37.3358, longitude: -122.0322)),
                name: "Cafetería de la Esquina", openingHours: nil, photos: [], address: "456 Avenida Secundaria, Ciudad, País",
                url: "http://cafeteriadelesquina.com", phoneNumber: "+987654321"
            ),
            PlaceDTO(id: "3", geometry: PlaceGeometryDTO(location: PlaceLocationDTO(latitude: 37.3398, longitude: -122.0332)),
                name: "Restaurante Gourmet", openingHours: nil, photos: [], address: "789 Calle Gourmet, Ciudad, País",
                url: "http://restaurantegourmet.com", phoneNumber: "+135792468"
            )
        ]

        return PlacesNearbySearchDTO(htmlAttributions: nil, results: mockArray, status: nil)
    }
}

private extension PlacesNearbySearch {
    static func makePlacesNearbySearch() -> PlacesNearbySearch {
        let mockArray = [
            Place(id: "1", name: "Librería Central", location: PlaceLocation(latitude: 37.3318, longitude: -122.0312),
                isOpen: false, schedule: [], photos: [], address: "123 Calle Principal, Ciudad, País",
                url: URL(string: "http://libreriacentral.com"), phoneNumber: "+123456789"
            ),
            Place(id: "2", name: "Cafetería de la Esquina", location: PlaceLocation(latitude: 37.3358, longitude: -122.0322),
                isOpen: false, schedule: [], photos: [], address: "456 Avenida Secundaria, Ciudad, País",
                url: URL(string: "http://cafeteriadelesquina.com"), phoneNumber: "+987654321"
            ),
            Place(id: "3", name: "Restaurante Gourmet", location: PlaceLocation(latitude: 37.3398, longitude: -122.0332),
                isOpen: false, schedule: [], photos: [], address: "789 Calle Gourmet, Ciudad, País",
                url: URL(string: "http://restaurantegourmet.com"), phoneNumber: "+135792468"
            )
        ]

        return PlacesNearbySearch(places: mockArray, totalPlaces: mockArray.count)
    }
}
