

public enum HttpMethod<Body> {
    case get
    case post(Body)

    var type: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        }
    }
}
