import RxSwift

public protocol NewsStore {

    func fetchStoryCollection() -> Single<StoryCollection>

    func fetchStory(withID id: String) -> Single<Story?>

}
