//
//  FeedViewController.swift
//  Quacker
//
//  Created by Witek Bobrowski on 19/03/2019.
//  Copyright © 2019 Witek Bobrowski. All rights reserved.
//

import UIKit

protocol FeedViewControllerDelegate: class {
    func feedViewController(
        _ feedViewController: FeedViewController, didSelect quack: Quack
    )
}

class FeedViewController: UIViewController {

    private lazy var tableView: UITableView = create {
        $0.estimatedRowHeight = 80
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
    }

    private var quacks: [Quack] = []

    weak var delegate: FeedViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension FeedViewController {
    private func setupView() {
        navigationItem.title = "Latest Quacks"
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.feedViewController(self, didSelect: quacks[indexPath.row])
    }
}

extension FeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quacks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = quacks[indexPath.row].text
        return cell
    }
}
