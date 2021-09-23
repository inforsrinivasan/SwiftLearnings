import UIKit

public struct CellDescriptor {
    public let configure: (UITableViewCell) -> ()
    public let reuseIdentifier: String
    public let cellType: UITableViewCell.Type

    public init<Cell: UITableViewCell>(reuseIdentifier: String, configure: @escaping (Cell) -> ()) {
        self.reuseIdentifier = reuseIdentifier
        self.cellType = Cell.self
        self.configure = { cell in
            configure(cell as! Cell)
        }
    }
}

public final class GenericViewController<Item>: UITableViewController {

    private let items: [Item]
    private let cellDescriptor: (Item) -> CellDescriptor
    private var reuseIdentifiers = Set<String>()

    public var didSelect: (Item) -> () = { _ in }

    public init(items: [Item], cellDescriptor: @escaping (Item) -> CellDescriptor) {
        self.items = items
        self.cellDescriptor = cellDescriptor
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let descriptor = cellDescriptor(item)

        if !reuseIdentifiers.contains(descriptor.reuseIdentifier) {
            tableView.register(descriptor.cellType, forCellReuseIdentifier: descriptor.reuseIdentifier)
            reuseIdentifiers.insert(descriptor.reuseIdentifier)
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: descriptor.reuseIdentifier, for: indexPath)
        descriptor.configure(cell)
        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelect(item)
    }

}
