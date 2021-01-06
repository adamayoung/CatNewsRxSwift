import Foundation
import RxSwift

public final class NewsHTTPStore: NewsStore {

    public static let shared = NewsHTTPStore()

    private let client: HTTPClient

    init(client: HTTPClient = HTTPMockClient()) {
        self.client = client
    }

    public func fetchStoryCollection() -> Single<StoryCollection> {
        client.get(.newsList)
    }

    public func fetchStory(withID id: String) -> Single<Story?> {
        client.get(.story(storyID: id))
            .map { (story: Story) -> Story? in
                Optional(story)
            }
            .catch { error in
                if error is NotFoundError {
                    return Single.just(nil)
                }

                return Single.error(error)
            }
    }

}
