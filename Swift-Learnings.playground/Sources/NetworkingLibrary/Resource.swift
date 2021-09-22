
import Foundation

public struct Resource<A> {
    var urlRequest: URLRequest
    let parse: (Data) -> A?
}

public extension Resource where A: Decodable {
    init<Body: Encodable>(url: URL, method: HttpMethod<Body>) {
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.type
        switch method {
        case .get: break
        case .post(let encodableBody):
            urlRequest.httpBody = try? JSONEncoder().encode(encodableBody)
        }
        self.parse = { data in
            try? JSONDecoder().decode(A.self, from: data)
        }
    }

    init(get url: URL) {
        self.urlRequest = URLRequest(url: url)
        self.parse = { data in
            try? JSONDecoder().decode(A.self, from: data)
        }
    }
}

public extension Resource {
    func map<B>(_ transform: @escaping (A) -> B) -> Resource<B> {
        return Resource<B>(urlRequest: urlRequest) { data in
            self.parse(data).map(transform)
        }
    }
}

public extension Resource {
    var combined: CombinedResource<A> {
        return .single(self)
    }
}
