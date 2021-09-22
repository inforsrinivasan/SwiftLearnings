
public struct Node<Value> {
    var value: Value
    private(set) var children: [Node]

    public var count: Int {
        return 1 + children.reduce(0) { $0 + $1.count }
    }

    public init(_ value: Value) {
        self.value = value
        self.children = []
    }

    public init(_ value: Value, @NodeBuilder builder: () -> [Node]) {
        self.value = value
        self.children = builder()
    }

    public init(_ value: Value, children: [Node]) {
        self.value = value
        self.children = children
    }

    public mutating func add(child: Node) {
        children.append(child)
    }
}

extension Node: Equatable where Value: Equatable {}
extension Node: Hashable where Value: Hashable {}
extension Node: Codable where Value: Codable {}

extension Node where Value: Equatable {
    public func find(_ value: Value) -> Node? {
        if self.value == value { return self }
        for child in children {
            if let match = child.find(value) {
                return match
            }
        }
        return nil
    }
}

@resultBuilder
public struct NodeBuilder {
    public static func buildBlock<Value>(_ children: Node<Value>...) -> [Node<Value>] {
        children
    }
}
