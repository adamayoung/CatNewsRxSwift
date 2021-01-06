@testable import CatNewsCore
import XCTest

final class MockHTTPClient: HTTPClient {

    var lastEndpoint: Endpoint?
    var getResponse: Decodable?
    var getError: Error?

    func get<Response: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<Response, Error>) -> Void) {
        lastEndpoint = endpoint
        DispatchQueue.main.async { [weak self] in
            if let error = self?.getError {
                completion(.failure(error))
                return
            }

            guard let response = self?.getResponse as? Response else {
                XCTFail("Can't cast response to type \(String(describing: Response.self))")
                return
            }

            completion(.success(response))
        }
    }

}
