//
//  PokemonListWireframe.swift
//  Pokedex
//
//  Created by Balint Lakatos on 02.12.2022.
//

import UIKit

import PokemonAPI

protocol PokemonListWireframeProtocol: AnyObject {

    func makePokemonListViewController() -> UIViewController
    func presentPokemonDetails(pokemon: PKMNamedAPIResource<PKMPokemon>, from: UIViewController)
}

final class PokemonListWireframe: PokemonListWireframeProtocol {

    private var pokemonListPresenter: PokemonListPresenter?
    private var pokemonDetailWireframe: PokemonDetailWireframe?

    func makePokemonListViewController() -> UIViewController {
        let pokemonListViewController = PokemonListViewController()
        let pokemonListInteractor = PokemonListInteractor()
        pokemonListPresenter = PokemonListPresenter(view: pokemonListViewController,
                                                    interactor: pokemonListInteractor)
        pokemonListPresenter?.wireframe = self
        return pokemonListViewController
    }

    func presentPokemonDetails(pokemon: PKMNamedAPIResource<PKMPokemon>, from view: UIViewController) {
        guard let pokemonName = pokemon.name else { return }
        pokemonDetailWireframe = PokemonDetailWireframe()
        guard let viewController = pokemonDetailWireframe?.makePokemonDetailViewController(pokemonName: pokemonName) else { return }
        view.navigationController?.pushViewController(viewController, animated: true)
    }
}
