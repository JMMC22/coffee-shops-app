//
//  GooglePlacesRepositoryTests.swift
//  CoworkingAppTests
//
//  Created by José María Márquez Crespo on 1/8/24.
//

import XCTest
@testable import CoworkingApp

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
    
    func test_get_nearby_places_error_return_response_when_datasource_return_response() async throws {
        // GIVEN
        let result: Result<PlacesNearbySearchDTO, RequestError> = .failure(.decode)
        let remoteStub = GooglePlacesRemoteDatasourceStub(getNearbyPlacesResult: result)
        let localStub = GooglePlacesUserDefaultsDatasourceStub()

        let sut = DefaultGooglePlacesRepository(googlePlacesRemoteDatasource: remoteStub,
                                                googlePlacesUserDefaultsDatasource: localStub)
        // WHEN
        let capturedResult = await sut.getNearbyPlaces(location: "", radius: "", keyword: "")

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected error -> got success")
            return
        }

        XCTAssertEqual(error, .decode)
    }
    
    func test_get_place_details_places_success_return_response_when_datasource_return_response() async throws {
        // GIVEN
        let mockResponse = PlaceDetailsDTO.makePlaceInfo()
        let result: Result<PlaceDetailsDTO, RequestError> = .success(mockResponse)
        let remoteStub = GooglePlacesRemoteDatasourceStub(getPlaceDetailsResult: result)
        let localStub = GooglePlacesUserDefaultsDatasourceStub()

        let sut = DefaultGooglePlacesRepository(googlePlacesRemoteDatasource: remoteStub,
                                                googlePlacesUserDefaultsDatasource: localStub)
        // WHEN
        let capturedResult = await sut.getPlaceDetails(id: "")

        // THEN
        let place = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(place, Place.makePlace())
    }
    
    func test_get_place_details_places_error_return_response_when_datasource_return_response() async throws {
        // GIVEN
        let result: Result<PlaceDetailsDTO, RequestError> = .failure(.decode)
        let remoteStub = GooglePlacesRemoteDatasourceStub(getPlaceDetailsResult: result)
        let localStub = GooglePlacesUserDefaultsDatasourceStub()

        let sut = DefaultGooglePlacesRepository(googlePlacesRemoteDatasource: remoteStub,
                                                googlePlacesUserDefaultsDatasource: localStub)
        // WHEN
        let capturedResult = await sut.getPlaceDetails(id: "")

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected error -> got success")
            return
        }

        XCTAssertEqual(error, .decode)
    }
    
    func test_get_favourites_places_success_return_nonEmpty_array_when_datasource_return_nonEmpty_array() throws {
        // GIVEN
        let mockResponse = PlaceUDS.makePlaces()
        let result: Result<[PlaceUDS], RequestError> = .success(mockResponse)
        let localStub = GooglePlacesUserDefaultsDatasourceStub(fetchFavouritesResult: result)
        let remoteStub = GooglePlacesRemoteDatasourceStub()

        let sut = DefaultGooglePlacesRepository(googlePlacesRemoteDatasource: remoteStub,
                                                googlePlacesUserDefaultsDatasource: localStub)
        // WHEN
        let capturedResult = sut.fetchFavouritesPlaces()

        // THEN
        let place = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(place, Place.makePlaces())
    }
    
    func test_get_favourites_places_success_return_empty_array_when_datasource_return_empty_array() throws {
        // GIVEN
        let result: Result<[PlaceUDS], RequestError> = .success([])
        let localStub = GooglePlacesUserDefaultsDatasourceStub(fetchFavouritesResult: result)
        let remoteStub = GooglePlacesRemoteDatasourceStub()

        let sut = DefaultGooglePlacesRepository(googlePlacesRemoteDatasource: remoteStub,
                                                googlePlacesUserDefaultsDatasource: localStub)
        // WHEN
        let capturedResult = sut.fetchFavouritesPlaces()

        // THEN
        let place = try XCTUnwrap(capturedResult.get())
        XCTAssertEqual(place, [])
    }
    
    func test_get_favourites_places_error_return_decode_error_when_datasource_return_decode_error() throws {
        // GIVEN
        let result: Result<[PlaceUDS], RequestError> = .failure(.decode)
        let localStub = GooglePlacesUserDefaultsDatasourceStub(fetchFavouritesResult: result)
        let remoteStub = GooglePlacesRemoteDatasourceStub()

        let sut = DefaultGooglePlacesRepository(googlePlacesRemoteDatasource: remoteStub,
                                                googlePlacesUserDefaultsDatasource: localStub)
        // WHEN
        let capturedResult = sut.fetchFavouritesPlaces()

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected error -> got success")
            return
        }

        XCTAssertEqual(error, .decode)
    }
    
    func test_is_favourite_place_success_return_true_array_when_datasource_return_true() throws {
        // GIVEN
        let mockResponse = PlaceUDS.makePlaces()
        let result: Result<[PlaceUDS], RequestError> = .success(mockResponse)
        let localStub = GooglePlacesUserDefaultsDatasourceStub(fetchFavouritesResult: result)
        let remoteStub = GooglePlacesRemoteDatasourceStub()

        let sut = DefaultGooglePlacesRepository(googlePlacesRemoteDatasource: remoteStub,
                                                googlePlacesUserDefaultsDatasource: localStub)
        // WHEN
        let capturedResult = sut.isFavouritePlace(id: "2")

        // THEN
        XCTAssertTrue(capturedResult)
    }
    
    func test_is_favourite_place_success_return_false_array_when_datasource_return_false() throws {
        // GIVEN
        let mockResponse = PlaceUDS.makePlaces()
        let result: Result<[PlaceUDS], RequestError> = .success(mockResponse)
        let localStub = GooglePlacesUserDefaultsDatasourceStub(fetchFavouritesResult: result)
        let remoteStub = GooglePlacesRemoteDatasourceStub()

        let sut = DefaultGooglePlacesRepository(googlePlacesRemoteDatasource: remoteStub,
                                                googlePlacesUserDefaultsDatasource: localStub)
        // WHEN
        let capturedResult = sut.isFavouritePlace(id: "3")

        // THEN
        XCTAssertFalse(capturedResult)
    }
    
    func test_update_favourite_place_success_return_updated_array_when_datasource_return_updated() throws {
        // GIVEN
        let mockPlace = Place(id: "4", name: "Librería Central 3", location: PlaceLocation(latitude: 37.3318, longitude: -122.0312),
                              isOpen: false, schedule: [], photos: [], address: "123 Calle Principal, Ciudad, País",
                              url: URL(string: "http://libreriacentral.com"), phoneNumber: "+123456789")
        let mockResponse = PlaceUDS.makePlaces()
        let result: Result<[PlaceUDS], RequestError> = .success(mockResponse)
        let updateResult: Result<Bool, RequestError> = .success(true)
        let localStub = GooglePlacesUserDefaultsDatasourceStub(fetchFavouritesResult: result, saveFavouriteResult: updateResult)
        let remoteStub = GooglePlacesRemoteDatasourceStub()

        let sut = DefaultGooglePlacesRepository(googlePlacesRemoteDatasource: remoteStub,
                                                googlePlacesUserDefaultsDatasource: localStub)
        // WHEN
        let capturedResult = sut.updateFavouritePlace(mockPlace)

        // THEN
        let updated = try XCTUnwrap(capturedResult.get())
        XCTAssertTrue(updated)
    }

    func test_update_favourite_place_success_return_removed_array_when_datasource_return_removed() throws {
        // GIVEN
        let mockResponse = PlaceUDS.makePlaces()
        let result: Result<[PlaceUDS], RequestError> = .success(mockResponse)
        let removeResult: Result<Bool, RequestError> = .success(false)
        let localStub = GooglePlacesUserDefaultsDatasourceStub(fetchFavouritesResult: result, removeFavouriteResult: removeResult)
        let remoteStub = GooglePlacesRemoteDatasourceStub()

        let sut = DefaultGooglePlacesRepository(googlePlacesRemoteDatasource: remoteStub,
                                                googlePlacesUserDefaultsDatasource: localStub)
        // WHEN
        let capturedResult = sut.updateFavouritePlace(Place.makePlace())

        // THEN
        let removed = try XCTUnwrap(capturedResult.get())
        XCTAssertFalse(removed)
    }
    
    func test_update_favourite_place_error_return_decode_error_when_datasource_return_error() throws {
        // GIVEN
        let result: Result<[PlaceUDS], RequestError> = .failure(.decode)
        let removeResult: Result<Bool, RequestError> = .success(false)
        let localStub = GooglePlacesUserDefaultsDatasourceStub(fetchFavouritesResult: result, removeFavouriteResult: removeResult)
        let remoteStub = GooglePlacesRemoteDatasourceStub()

        let sut = DefaultGooglePlacesRepository(googlePlacesRemoteDatasource: remoteStub,
                                                googlePlacesUserDefaultsDatasource: localStub)
        // WHEN
        let capturedResult = sut.updateFavouritePlace(Place.makePlace())

        // THEN
        guard case .failure(let error) = capturedResult else {
            XCTFail("Expected error -> got success")
            return
        }

        XCTAssertEqual(error, .decode)
    }
}

private extension PlacesNearbySearchDTO {
    static func makePlacesNearbySearch() -> PlacesNearbySearchDTO {
        let mockArray = [
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

private extension PlaceDetailsDTO {
    static func makePlaceInfo() -> PlaceDetailsDTO {
        let placeDto = PlaceDTO(id: "1", geometry: PlaceGeometryDTO(location: PlaceLocationDTO(latitude: 37.3318, longitude: -122.0312)),
                                name: "Librería Central", openingHours: nil, photos: [], address: "123 Calle Principal, Ciudad, País",
                                url: "http://libreriacentral.com", phoneNumber: "+123456789"
        )

        return PlaceDetailsDTO(htmlAttributions: nil, result: placeDto, status: nil)
    }
}

private extension Place {
    static func makePlace() -> Place {
        return Place(id: "1", name: "Librería Central", location: PlaceLocation(latitude: 37.3318, longitude: -122.0312),
                     isOpen: false, schedule: [], photos: [], address: "123 Calle Principal, Ciudad, País",
                     url: URL(string: "http://libreriacentral.com"), phoneNumber: "+123456789")
    }

    static func makePlaces() -> [Place] {
        return [
            Place(id: "1", name: "Librería Central", location: PlaceLocation(latitude: 37.3318, longitude: -122.0312),
                  isOpen: false, schedule: [], photos: [], address: "123 Calle Principal, Ciudad, País",
                  url: URL(string: "http://libreriacentral.com"), phoneNumber: "+123456789", isFavourite: true),
            Place(id: "2", name: "Cafetería de la Esquina", location: PlaceLocation(latitude: 37.3358, longitude: -122.0312),
                  isOpen: false, schedule: [], photos: [], address: "123 Calle Principal, Ciudad, País",
                  url: URL(string: "http://cafeteriadelesquina.com"), phoneNumber: "+123456789", isFavourite: true)
        ]
    }
}

private extension PlaceUDS {
    static func makePlaces() -> [PlaceUDS] {
        return [
            PlaceUDS(id: "1", name: "Librería Central", location: PlaceLocationUDS(latitude: 37.3318, longitude: -122.0312),
                     isOpen: false, address: "123 Calle Principal, Ciudad, País", url: URL(string: "http://libreriacentral.com"),
                     phoneNumber: "+123456789", isFavourite: true),
            PlaceUDS(id: "2", name: "Cafetería de la Esquina", location: PlaceLocationUDS(latitude: 37.3358, longitude: -122.0312),
                     isOpen: false, address: "456 Avenida Secundaria, Ciudad, País", url: URL(string: "http://cafeteriadelesquina.com"),
                     phoneNumber: "+123456789", isFavourite: true)
        ]
    }
}
