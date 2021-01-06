import Foundation
import os.log
import RxSwift

struct HTTPMockClient: HTTPClient {

    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder

    init(urlSession: URLSession = URLSession(configuration: .ephemeral), jsonDecoder: JSONDecoder = .catNews) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }

    func get<Response: Decodable>(_ endpoint: Endpoint) -> Single<Response> {
        let url = endpoint.url
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        os_log("GET %@", log: .api, url.absoluteString)

        return Single.create { single in
            let task = urlSession.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    os_log("Error: GET %@ - %@", log: .api, type: .error, url.absoluteString,
                           error.localizedDescription)
                    single(.failure(error))
                    return
                }

                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 404 {
                    os_log("Not found: GET %@", log: .api, type: .error, url.absoluteString)
                    single(.failure(NotFoundError()))
                    return
                }

                guard let data = data else {
                    os_log("Not found: GET %@ - not response data", log: .api, type: .error, url.absoluteString)
                    single(.failure(NotFoundError()))
                    return
                }

                do {
                    let result = try jsonDecoder.decode(Response.self, from: data)
                    single(.success(result))
                } catch let error {
                    os_log("Error: GET %@ - %@", log: .api, type: .error, url.absoluteString,
                           error.localizedDescription)
                    single(.failure(error))
                }
            }

            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }

}

private extension Endpoint {

    private static var baseURL: URL {
        URL(string: "https://raw.githubusercontent.com/adamayoung/CatNewsRxSwift/main/Packages/CatNewsCore/Tests/CatNewsCoreTests/MockData")!
    }

    var url: URL {
        switch self {
        case .newsList:
            return Self.baseURL.appendingPathComponent("news-list.json")

        case .story(let storyID):
            return Self.baseURL.appendingPathComponent("story-\(storyID).json")
        }
    }

}
