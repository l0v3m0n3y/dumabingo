import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension URLSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: URLError(.unknown))
                }
            }
            task.resume()
        }
    }
}


public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public class dumaBingo {

    private let api = "https://dumabingo.org/assets"
    private let deklaratorApi = "https://api.deklarator.org"

    private var headers: [String: String]

    public init() {
        self.headers = [
            "Connection": "keep-alive",
            "Accept-Encoding": "deflate, zstd",
            "Accept-Language": "en-US,en;q=0.9",
            "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36"
        ]
    }

    private func fetchJSON(from urlString: String,method: HTTPMethod = .get,body: Data? = nil,queryParameters: [String: String]? = nil) async throws -> Any {
        var urlComponents = URLComponents(string: urlString)
        if let queryParameters = queryParameters {
            urlComponents?.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let url = urlComponents?.url else {
            throw NSError(domain: "Invalid URL", code: -1)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        if let body = body {
            request.httpBody = body
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONSerialization.jsonObject(with: data)
    }

    public func getRatingList() async throws -> Any {
        try await fetchJSON(
            from: "\(api)/data/rating.json"
        )
    }

    public func getAliasList() async throws -> Any {
        try await fetchJSON(
            from: "\(api)/data/alias.json"
        )
    }

    public func getLobbistList(category: String ="sf") async throws -> Any {
        try await fetchJSON(
            from: "\(deklaratorApi)/media/dumps/lobbist-small-\(category).json"
        )
    }

    public func getLobbiList() async throws -> Any {
        try await fetchJSON(
            from: "\(deklaratorApi)/api/lobby_group/"
        )
    }

    public func getConvocationById(convocationId: Int) async throws -> Any {
        try await fetchJSON(
            from: "\(deklaratorApi)/api/convocations/\(convocationId)/person_convocations",
            queryParameters: ["format": "json"]
        )
    }

    public func getLobbistDetailById(lobbistId: Int) async throws -> Any {
        try await fetchJSON(
            from: "\(deklaratorApi)/api/lobbist_detail/\(lobbistId)/"
        )
    }

    public func searchPersonSections(personId: Int) async throws -> Any {
        try await fetchJSON(
            from: "\(deklaratorApi)/api/v1/search/sections/",
            queryParameters: ["person": String(personId)]
        )
    }

    public func getPersonSuccessRate(personId: Int) async throws -> Any {
        try await fetchJSON(
            from: "\(deklaratorApi)/api/persons/\(personId)/success_rate",
            queryParameters: ["format": "json"]
        )
    }

    public func getLawById(lawId: Int) async throws -> Any {
        try await fetchJSON(
            from: "\(deklaratorApi)/api/law_draft_api/\(lawId)/"
        )
    }
}
