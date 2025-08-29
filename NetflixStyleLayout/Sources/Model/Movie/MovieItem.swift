//
//  MovieItem.swift
//  NetflixStyleLayout
//
//  Created by HYUN SUNG on 8/29/25.
//


struct MovieResponse: Codable {
    let items: [MovieItemElement]?
}

// MARK: - MovieItemElement
struct MovieItemElement: Codable {
    let id: Int?
    let url: String?
    let name: String?
    let type: String?
    let language: String?
    let genres: [String]?
    let status: MovieStatus?
    let runtime: Int?
    let averageRuntime: Int?
    let premiered: String?
    let ended: String?
    let officialSite: String?
    let schedule: MovieSchedule?
    let rating: MovieRating?
    let weight: Int?
    let network, webChannel: MovieNetwork?
    let dvdCountry: Country?
    let externals: MovieExternals?
    let image: MovieImage?
    let summary: String?
    let updated: Int?
    let links: MovieLinks?

    enum CodingKeys: String, CodingKey {
        case id, url, name, type, language, genres, status, runtime, averageRuntime, premiered, ended, officialSite, schedule, rating, weight, network, webChannel, dvdCountry, externals, image, summary, updated
        case links = "_links"
    }
}

enum MovieStatus: String, Codable {
    case ended = "Ended"
    case running = "Running"
    case toBeDetermined = "To Be Determined"
}

// MARK: - MovieImage
struct MovieImage: Codable {
    let medium, original: String?
}

// MARK: - MovieSchedule
struct MovieSchedule: Codable {
    let time: String?
    let days: [String]?
}

// MARK: - MovieRating
struct MovieRating: Codable {
    let average: Double?
}

// MARK: - MovieNetwork
struct MovieNetwork: Codable {
    let id: Int?
    let name: String?
    let country: Country?
    let officialSite: String?
}

// MARK: - Country
struct Country: Codable {
    let name: String?
    let code: String?
    let timezone: String?
}

// MARK: - MovieExternals
struct MovieExternals: Codable {
    let tvrage: Int?
    let thetvdb: Int?
    let imdb: String?
}


// MARK: - MovieLinks
struct MovieLinks: Codable {
    let linksSelf: MovieSelfClass?
    let previousepisode, nextepisode: MovieEpisode?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case previousepisode, nextepisode
    }
}

// MARK: - MovieSelfClass
struct MovieSelfClass: Codable {
    let href: String?
}

// MARK: - MovieEpisode
struct MovieEpisode: Codable {
    let href: String?
    let name: String?
}
