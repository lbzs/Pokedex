//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Balint Lakatos on 25.11.2022.
//

import UIKit

import PokemonAPI

protocol PokemonListProtocol: AnyObject {

    var eventHandler: PokemonListEventHandlerProtocol? { get set }

    func showPokemons(pokemons: [PKMNamedAPIResource<PKMPokemon>])
}

final class PokemonListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PokemonListProtocol {

    weak var eventHandler: PokemonListEventHandlerProtocol?

    private lazy var tableView = UITableView(frame: .zero)

    private var pokemons: [PKMNamedAPIResource<PKMPokemon>] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        setupUI()
        layoutUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        eventHandler?.handle(event: .updateView)
    }

    private func initUI() {
        view.addSubview(tableView)
    }

    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func layoutUI() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard pokemons.count > indexPath.row else { return }
        eventHandler?.handle(event: .presentDetail(pokemon: pokemons[indexPath.row], from: self))
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: .zero)

        if pokemons.count > indexPath.row {
            cell.textLabel?.text = pokemons[indexPath.row].name
        }

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }

    // MARK: - PokemonListProtocol

    func showPokemons(pokemons: [PKMNamedAPIResource<PKMPokemon>]) {
        self.pokemons = pokemons

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
