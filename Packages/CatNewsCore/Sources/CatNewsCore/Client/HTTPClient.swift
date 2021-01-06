import Foundation
import RxSwift

protocol HTTPClient {

    func get<Response: Decodable>(_ endpoint: Endpoint) -> Single<Response>

}
