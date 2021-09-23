
import UIKit
import PlaygroundSupport

struct Season {
    let title: String
}

struct Episode {
    let episode: String
}

let seasonsStub = [Season(title: "Season 1"),
                   Season(title: "Season 2"),
                   Season(title: "Season 3"),
                   Season(title: "Season 4"),
                   Season(title: "Season 5")]

let episodesStub = [Episode(episode: "Ep 1"),
                    Episode(episode: "Ep 2")]


final class SeasonCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class EpisodeCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum RecentItems {
    case season(Season)
    case episode(Episode)
}

let recentItemStub: [RecentItems] = [ .season(.init(title: "Season 1")),
                                      .season(.init(title: "Season 2")),
                                      .episode(.init(episode: "Episode1")),
                                      .season(.init(title: "Season 3")),
                                      .episode(.init(episode: "Episode 4"))
]

let recentsVC = GenericViewController(items: recentItemStub) { recentItem in
    switch recentItem {
    case .episode(let episode):
        return CellDescriptor(reuseIdentifier: "episode") { (cell: EpisodeCell) in
            cell.textLabel?.text = episode.episode
        }
    case .season(let season):
        return CellDescriptor(reuseIdentifier: "season") { (cell: SeasonCell) in
            cell.textLabel?.text = season.title
        }
    }
}

let navigationController = UINavigationController(rootViewController: recentsVC)
navigationController.view.frame = CGRect(x: 0, y: 0, width: 320, height: 520)
recentsVC.title = "Recents"
PlaygroundPage.current.liveView = navigationController.view


