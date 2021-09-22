import Foundation

public indirect enum CombinedResource<A> {
    case single(Resource<A>)
    case _sequence(CombinedResource<Any>, (Any) -> CombinedResource<A>)
}

public extension CombinedResource {

    var asAny: CombinedResource<Any> {
        switch self {
        case let .single(r):
            return .single(r.map { $0 })
        case let ._sequence(prevResource, transform):
            return ._sequence(prevResource) { x in
                transform(x).asAny
            }
        }
    }

    func flatMap<B>(_ transform: @escaping (A) -> CombinedResource<B>) -> CombinedResource<B> {
        return CombinedResource<B>._sequence(self.asAny) { unwrappedPreviousResourceResult in
            transform(unwrappedPreviousResourceResult as! A)
        }
    }
}
