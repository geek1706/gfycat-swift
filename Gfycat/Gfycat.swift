//
//  Gfycat.swift
//  Gfycat
//
//  Created by trungnd on 9/28/16.
//  Copyright © 2016 redvn. All rights reserved.
//

import Foundation

/// Gfycat
public struct Gfycat {
    let gfyId: String
    let gfyName: String
    let gfyNumber: String?
    let webmUrl: String?
    let mobileUrl: String?
    let mobilePosterUrl: String?
    let posterUrl: String?
    let thumb360Url: String?
    let thumb360PosterUrl: String?
    let thumb100PosterUrl: String?
    let max5mbGif: String?
    let max2mbGif: String?
    let mjpgUrl: String?
    let width: Int?
    let height: Int?
    let avgColor: String?
    let frameRate: Int?
    let numFrames: Int?
    let mp4Size: Int64?
    let webmSize: Int64?
    let source: Bool?
    let createDate: Date?
    let nsfw: Bool?
    let mp4Url: String?
    let likes: Int?
    let dislikes: Int?
    let extraLemmas: String?
    let md5: String?
    let views: Int?
    let tags: String?
    let userName: String?
    let title: String?
    let description: String?
    let languageCategories: String?
}

/// Gfycats
public struct Gfycats {

    /// results
    let items: [Gfycat]

    /// curfor for paging
    let cursor: String?

    ///total items in results
    let found: Int?

    // Initialize from json
    init?(json: Any) {
        guard let json = json as? [String: Any] else { return nil }
        // Initialize properties
        self.items = Gfycat.parses(jsons: json["gfycats"])
        self.found = json["found"] as? Int
        self.cursor = json["cursor"] as? String
    }
}


// MARK: - JSON parsing
extension Gfycat {
    init?(json: Any) {
        guard let json = json as? [String: Any] else { return nil }
        guard let gfyId = (json["gfyId"] as? String),
            let gfyName = (json["gfyName"] as? String)
        else {
            return nil
        }
        // Initialize properties
        self.gfyId = gfyId
        self.gfyName = gfyName
        self.gfyNumber = json["gfyNumber"] as? String
        self.webmUrl = json["webmUrl"] as? String
        self.mobileUrl = json["mobileUrl"] as? String
        self.mobilePosterUrl = json["mobilePosterUrl"] as? String
        self.posterUrl = json["posterUrl"] as? String
        self.thumb360Url = json["thumb360Url"] as? String
        self.thumb360PosterUrl = json["thumb360PosterUrl"] as? String
        self.thumb100PosterUrl = json["thumb100PosterUrl"] as? String
        self.max5mbGif = json["max5mbGif"] as? String
        self.max2mbGif = json["max2mbGif"] as? String
        self.mjpgUrl = json["max2mbGif"] as? String
        self.width = json["width"] as? Int
        self.height = json["height"] as? Int
        self.avgColor = json["avgColor"] as? String
        self.frameRate = json["frameRate"] as? Int
        self.numFrames = json["numFrames"] as? Int
        self.mp4Size = json["mp4Size"] as? Int64
        self.webmSize = json["webmSize"] as? Int64
        self.source = json["source"] as? Bool
        self.createDate = json["createDate"] as? Date
        self.nsfw = json["nsfw"] as? Bool
        self.mp4Url = json["mp4Url"] as? String
        self.likes = json["likes"] as? Int
        self.dislikes = json["dislikes"] as? Int
        self.extraLemmas = json["extraLemmas"] as? String
        self.md5 = json["md5"] as? String
        self.views = json["views"] as? Int
        self.tags = json["tags"] as? String
        self.userName = json["userName"] as? String
        self.title = json["title"] as? String
        self.description = json["description"] as? String
        self.languageCategories = json["languageCategories"] as? String
    }
    static func parses(jsons: Any) -> [Gfycat] {
        guard let jsons = jsons as? [Any] else { return [] }
        return jsons.flatMap { Gfycat(json: $0) }
    }
}

/// Tag Name
public typealias Tag = String

public struct PopulatedTags {
    
    let items: [PopulatedTag]
    let cursor: String?
}

// MARK: - JSON parsing
extension PopulatedTags {
    
    init?(json: Any) {
        guard let json = json as? [String: Any] else { return nil }
        
        // Initialize properties
        self.items = PopulatedTag.parses(jsons: json["tags"])
        self.cursor = json["cursor"] as? String
    }
}

public struct PopulatedTag {

    ///  A tag
    let tag: Tag

    /// Cusor for paging
    let cursor: String?

    /// A gfycat collection with specified tag
    let items: [Gfycat]
}

// MARK: - JSON parsing
extension PopulatedTag {

    init?(json: Any) {
        guard let json = json as? [String: Any] else { return nil }

        // Initialize properties
        self.tag = json["tag"] as! String
        self.cursor = json["cursor"] as? String
        self.items = Gfycat.parses(jsons: json["gfycats"])
    }
    
    static func parses(jsons: Any) -> [PopulatedTag] {
        guard let jsons = jsons as? [Any] else { return [] }
        return jsons.flatMap { PopulatedTag(json: $0) }
    }
}

/// Endpoint Protocol
protocol RequestType {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
}


/// Trending Tags
///
/// - tag: trending tags
/// - populated: pre-populated with a gfycat collection
enum Trending {
    case tag
    case populated(Int?, Int?, String?)
}

// MARK: - Endpoints
enum GfycatRequestType {
    case trending(String?, String?, Int?)
    case trendingTags(Trending)
    case search(String, Int?, String?)
}

extension GfycatRequestType: RequestType {

    var baseURL: String {
        return "https://api.gfycat.com/v1test/"
    }

    var path: String {

        switch self {

        case .trending(_):
            return "gfycats/trending"

        case .search(_, _, _):
            return "gfycats/search"

        case .trendingTags(let tagType):

            switch tagType {

            case .tag:
                return "tags/trending"

            case .populated(_, _, _):
                return "tags/trending/populated"
            }
        }
    }

    var parameters: [String : Any]? {

        switch self {

        case .trending(let tagName, let cursor, let count):

            var parameter = [String : Any]()

            if let tagName = tagName {
                parameter["tagName"] = tagName
            }

            if let cursor = cursor {
                parameter["cursor"] = cursor
            }

            if let count = count {
                parameter["count"] = "\(count)"
            }

            return parameter

        case .trendingTags(let tagType):

            switch tagType {

            case .tag: return nil

            case .populated(let tagCount, let gfyCount, let cursor):

                var parameter = [String : Any]()

                if let tagCount = tagCount {
                    parameter["tagCount"] = "\(tagCount)"
                }

                if let gfyCount = gfyCount {
                    parameter["gfyCount"] = "\(gfyCount)"
                }

                if let cursor = cursor {
                    parameter["cursor"] = cursor
                }

                return parameter
            }

        case .search(let searchText, let count, let cursor):

            var parameter = [String : Any]()

            if let count = count {
                parameter["count"] = "\(count)"
            }
            if let cursor = cursor {
                parameter["cursor"] = cursor
            }
            parameter["search_text"] = searchText

            return parameter
        }
    }
}


// MARK: - Gfycat
extension Gfycat {

    /// A shared session for interacting with the web service
    static var session: URLSession {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        return session
    }

    /// Get a list of trending gfycats, or a list of trending gfycats for a specific tag
    ///
    /// - Parameters:
    ///   - tagName: URL encoded tag name, to view trending gfycats for that tag
    ///   - count: Requested number of items to return
    ///   - cursor: Cursor for paging
    ///   - completionHandler: Completion handler after finishing task
    static func trending(_ tagName: String? = nil, count: Int? = nil, cursor: String? = nil, completionHandler: @escaping (Gfycats?, Error?) -> Void) {

        let router = GfycatRequestType.trending(tagName, cursor, count)

        Gfycat.request(router) { (JSON, error) in
            completionHandler(Gfycats(json: JSON), error)
        }
    }

    /// Get a list of currently trending tags, in order of their current trend “hotness”
    ///
    /// - Parameters:
    ///   - tagCount: The total number of tags to return
    ///   - cursor: Cursor for paging
    ///   - completionHandler: Completion handler after finishing task
    static func trendingTags(tagCount: Int? = 10, cursor: String? = nil, completionHandler: @escaping ([Tag]?, Error?) -> Void) {

        let router = GfycatRequestType.trendingTags(.tag)

        Gfycat.request(router) { (JSON, error) in
            completionHandler(JSON as? [Tag], error)
        }
    }

    /// Get a list of trending tags, with each tag pre-populated with a gfycat collection.
    ///
    /// - Parameters:
    ///   - tagCount: The total number of tags to return
    ///   - gfyCount: The total number of gfycats to return for each tag
    ///   - cursor: Cursor for paging
    ///   - completionHandler: Completion handler after finishing task
    static func trendingTagsPopulated(tagCount: Int = 5, gfyCount: Int = 10, cursor: String? = nil, completionHandler: @escaping (PopulatedTags?, Error?) -> Void) {

        let router = GfycatRequestType.trendingTags(.populated(tagCount, gfyCount, cursor))

        Gfycat.request(router) { (JSON, error) in
            completionHandler(PopulatedTags(json: JSON), error)
        }
    }


    /// Site search.
    /// Site search is limited to published Gfycats and will not always retrieve all content. Use account search to search all of a users personal Gfycats, published or not
    ///
    /// - Parameters:
    ///   - searchText: The text to search for
    ///   - count: The maximum total number of gfycats to return for the search
    ///   - cursor: URL encoded Cursor for paging through result set
    ///   - completionHandler: Completion handler after finishing task
    static func search(_ searchText: String, count: Int? = nil, cursor: String? = nil, completionHandler: @escaping (Gfycats?, Error?) -> Void ) {

        let router = GfycatRequestType.search(searchText, count, cursor)

        Gfycat.request(router) { (JSON, error) in
            completionHandler(Gfycats(json: JSON), error)
        }
    }

    /// Perform request
    ///
    /// - Parameters:
    ///   - router: A request type
    ///   - completionHandler: Completion handler after finishing task
    private static func request(_ router: RequestType, completionHandler: @escaping (Any?, Error?) -> Void) {
        let url = createURL(with: router)

        let task = session.dataTask(with: url) { (data, response, error) in

            guard let data = data else {
                completionHandler(nil, RequestError.failedToRetrieveData)
                return
            }

            do {
                let JSON = try JSONSerialization.jsonObject(with: data, options: .allowFragments)

                if let statusCode = (response as? HTTPURLResponse)?.statusCode {

                    switch statusCode {

                    case 200:
                        completionHandler(JSON, nil)
                        return

                    case 400:
                        completionHandler(nil, GfycatError(json: JSON))
                        return

                    case 404:
                        completionHandler(nil, GfycatError.error(.notFound))
                        return

                    case 401:
                        completionHandler(nil, GfycatError.error(.unauthorized))
                        return

                    case 503:
                        completionHandler(nil, GfycatError.error(.serviceNotAvailable))
                        return

                    default:
                        completionHandler(nil, GfycatError.error(.unknown))
                        return
                    }
                }
            } catch {
                completionHandler(nil, SerializationError.invalid)
            }
        }

        task.resume()
    }

    /// Construct URL Request with router
    ///
    /// - Parameter router: A request type
    /// - Returns: URL for request
    static func createURL(with router: RequestType) -> URL {
        var urlString = router.baseURL.appending(router.path)

        // Encode query items string
        if let parameters = router.parameters, parameters.count > 0 {
            var components = [String]()
            for (key, value) in parameters {
                if let value = value as? String {
                    components.append("\(escape(key))=\(escape(value))")
                }
            }
            urlString = urlString.appending("?").appending(components.joined(separator: "&"))
        }

        guard let url = URL(string: urlString) else {
            fatalError("Cannot create URL with: \(urlString)")
        }

        return url
    }


    /// Percent encoding
    ///
    /// - Parameter string: A input string to encode
    /// - Returns: A encoded string
    static func escape(_ string: String) -> String {
        guard let escaped = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return string
        }
        return escaped
    }
}

public enum RequestError: Error {
    case invalidURL
    case failedToRetrieveData
}

public enum SerializationError: Error {
    case invalid
}

/// Gfycat Error
struct GfycatError: Error {

    let code: String
    let description: String

    init(_ code: String, description: String) {
        self.code = code
        self.description = description
    }

    init?(json: Any) {

        guard let json = json as? [String: Any], let errorMessage = json["errorMessage"] as? [String: String], let code = errorMessage["code"], let description = errorMessage["description"] else {
            return nil
        }

        // Initialize properties

        self.code = code
        self.description = description
    }
}

extension GfycatError {
    enum ErrorType: String {
        case notFound
        case serviceNotAvailable
        case unauthorized
        case unknown
    }

    static func error(_ type: ErrorType) -> GfycatError {
        return GfycatError("Gfycat Error", description: type.rawValue)
    }
}
