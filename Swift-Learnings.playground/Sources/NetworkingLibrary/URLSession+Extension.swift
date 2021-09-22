import Foundation

public extension URLSession {
    func load<A>(_ resource: Resource<A>,
                 completion: @escaping (A?) -> ()) {
        dataTask(with: resource.urlRequest) { data, _, _ in
            completion(data.flatMap(resource.parse))
        }.resume()
    }
}

public extension URLSession {
    func load<A>(_ resource: CombinedResource<A>, completion: @escaping (A?) -> ()) {
        switch resource {
        case let .single(res): load(res, completion: completion)
        case let ._sequence(prev, transform):
            load(prev) { result in
                guard let unwrappedResult = result else { completion(nil); return }
                self.load(transform(unwrappedResult), completion: completion)
            }
        }
    }
}
