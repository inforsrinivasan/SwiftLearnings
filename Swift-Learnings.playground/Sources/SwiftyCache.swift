import Foundation

final class SwiftyCache<Key: Hashable, Value> {

    private let nsCache = NSCache<WrappedKey, WrappedValue>()

    func insert(_ value: Value, forkey key: Key) {
        let wrappedValue = WrappedValue(value)
        let wrappedKey = WrappedKey(key)
        nsCache.setObject(wrappedValue, forKey: wrappedKey)
    }

    func removeValue(forKey key: Key) {
        let wrappedKey = WrappedKey(key)
        nsCache.removeObject(forKey: wrappedKey)
    }

    func value(forKey key: Key) -> Value? {
        let wrappedKey = WrappedKey(key)
        guard let wrappedValue = nsCache.object(forKey: wrappedKey) else { return nil }
        return wrappedValue.value
    }

}

extension SwiftyCache {
    subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set {
            guard let val = newValue else {
                removeValue(forKey: key)
                return
            }
            insert(val, forkey: key)
        }
    }
}

private extension SwiftyCache {
    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) {
            self.key = key
        }

        override var hash: Int {
            return key.hashValue
        }

        override func isEqual(_ object: Any?) -> Bool {
            guard let val = object as? WrappedKey else { return false }
            return val.key == key
        }
    }
}

private extension SwiftyCache {
    final class WrappedValue {
        let value: Value

        init(_ value: Value) {
            self.value = value
        }
    }
}

