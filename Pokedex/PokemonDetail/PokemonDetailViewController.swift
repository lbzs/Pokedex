//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Balint Lakatos on 03.12.2022.
//

import UIKit

import PokemonAPI

protocol PokemonDetailProtocol: AnyObject {

    var eventHandler: PokemonDetailEventHandler? { get set }

    func showPokemon(_ pokemon: PKMPokemon)
    func showError(_ error: Error)
}

final class PokemonDetailViewController: UIViewController, PokemonDetailProtocol {

    weak var eventHandler: PokemonDetailEventHandler?

    private var pokemon: PKMPokemon? {
        didSet {
            updateUI()
        }
    }

    private lazy var nameLabel = UILabel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        eventHandler?.handle(event: .updateView)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        eventHandler?.handle(event: .viewDidDisappear)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        layoutUI()
        updateUI()
    }

    private func initUI() {
        view.addSubview(nameLabel)
        view.backgroundColor = .white
    }

    private func layoutUI() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }

    private func updateUI() {
        nameLabel.text = pokemon?.name
    }

    // MARK: - PokemonDetailProtocol

    func showPokemon(_ pokemon: PKMPokemon) {
        DispatchQueue.main.async {
            self.pokemon = pokemon
        }
    }

    func showError(_ error: Error) {
        
    }
}
