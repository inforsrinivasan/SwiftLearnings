import UIKit

public final class GenericViewController<Item, Cell: UITableViewCell>: UITableViewController {

    private let items: [Item]
    private let reuseIdentifier = "cell"
    private let configure: (Cell, Item) -> ()
    public var didSelect: (Item) -> () = { _ in }

    public init(items: [Item], configure: @escaping (Cell, Item) -> ()) {
        self.items = items
        self.configure = configure
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Cell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! Cell
        let item = items[indexPath.row]
        configure(cell, item)
        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        didSelect(item)
    }

}
