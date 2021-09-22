
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

let seasonsVC = GenericViewController<Season, SeasonCell>(items: seasonsStub) { cell, season in
    cell.textLabel?.text = season.title
}

let navigationController = UINavigationController(rootViewController: seasonsVC)
navigationController.view.frame = CGRect(x: 0, y: 0, width: 320, height: 520)
seasonsVC.title = "Seasons"
seasonsVC.didSelect = { season in
    let episodesVC = GenericViewController<Episode, EpisodeCell>(items: episodesStub) { cell, episode in
        cell.textLabel?.text = episode.episode
    }
    episodesVC.title = season.title
    navigationController.pushViewController(episodesVC, animated: true)
}
PlaygroundPage.current.liveView = navigationController.view
