@testable import CatNewsCore
import RxSwift
import XCTest

final class MockHTTPClient: HTTPClient {

    var lastEndpoint: Endpoint?
    var getResponse: Decodable?
    var getError: Error?

    func get<Response: Decodable>(_ endpoint: Endpoint) -> Single<Response> {
        lastEndpoint = endpoint

        return Single.create { single in
            DispatchQueue.main.async { [weak self] in
                if let error = self?.getError {
                    single(.failure(error))
                    return
                }

                guard let response = self?.getResponse as? Response else {
                    XCTFail("Can't cast response to type \(String(describing: Response.self))")
                    return
                }

                single(.success(response))
            }

            return Disposables.create { }
        }
    }

}
