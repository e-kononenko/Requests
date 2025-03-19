#### Disclaimer: This is a very early stage of the library's development! Everything can change at every moment, so do not use this library in production apps!

Simple way to fetch desired models from different sources (e.g API, Bundle, etc) in Swift apps. Supports async/await and Combine.

### Request
- Create your `Request` or use one of built-in protocols, such as `APIRequestJSON`
- Implement necessary properties or functions if needed
- Call `try await request.fetch()` or subscribe to `request.fetchPublisher()`


### API requests

#### Only GET requests are supported at the moment!

To fetch your response model from API, you need to create a type that conforms to the `APIRequest` protocol. 

There is also a `APIRequestJSON` type, that does the JSON decoding for you. 

Here is the example of usage:

```swift
struct CitySearchRequest: APIRequestJSON {
    typealias Output = [CityResponseModel]

    let scheme: Requests.API.Scheme = .https

    let host: String = "your.api.host.com"

    let path: String = "/path/to/search"

    let method: Requests.API.Method = .get

    var parameters: [String : String] {
        [
            "apiKey": "your_api_key", // please do not use hardcoded API keys 
            "query": query
        ]
    }

    let query: String
}
```

To get automatic decoding, your model should conform to `Decodable` protocol:
```swift
struct CityResponseModel: Decodable {
    let name: String
    let lat: Double
    let long: Double
}
```

Then call `fetch()` function if you use async/await:

```swift
let request = CitySearchRequest(query: "London")
let cityResponseModels: [CityResponseModel] = try await request.fetch()
```

Or use Combine Publisher:
```swift
request.fetchPublisher()
    .sink { completion in
        // handle completion
    } receiveValue: { cityResponseModels in
        print(cityResponseModels)
    }
    .store(in: &cancellables)
```

