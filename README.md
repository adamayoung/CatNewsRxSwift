# Cat News (RxSwift)

![Cat News](Docs/images/cat-news.png)

An app to allow users to look at stories of cute cats nearby 😸.

## Prototype data

The app uses [mock data](https://github.com/adamayoung/CatNews/tree/main/Packages/CatNewsCore/Tests/CatNewsCoreTests/MockData) hosted in the repo. When the production API is available, a new [HTTP Client](https://github.com/adamayoung/CatNews/tree/main/Packages/CatNewsCore/Sources/CatNewsCore/Client/HTTPClient.swift) will need to be implemented to use this API.

## Testing

The app contains unit tests as well as UI tests.

## Third-Party Swift Packages

### SDWebImage

The SDWebImage library is used to download images from the web.

Reference: [https://github.com/SDWebImage/SDWebImage](https://github.com/SDWebImage/SDWebImage)
