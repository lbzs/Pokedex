//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by Balint Lakatos on 27.11.2022.
//

import UIKit

import PokemonAPI

enum PokemonListEvent {
    case updateView
    case presentDetail(pokemon: PKMNamedAPIResource<PKMPokemon>, from: UIViewController)
}

protocol PokemonListEventHandlerProtocol: AnyObject {
    func handle(event: PokemonListEvent)
}

final class PokemonListPresenter: PokemonListEventHandlerProtocol, PokemonListInteractorDelegate {

    weak var wireframe: PokemonListWireframeProtocol?

    private let view: PokemonListProtocol
    private let interactor: PokemonListInteractor

    init(view: PokemonListProtocol, interactor: PokemonListInteractor) {
        self.view = view
        self.interactor = interactor
        self.view.eventHandler = self
        self.interactor.delegate = self
    }

    // MARK: - PokemonListPresenterProtocol

    func handle(event: PokemonListEvent) {
        switch event {
        case .updateView:
            interactor.fetchPokedex()
        case let .presentDetail(pokemon, view):
            wireframe?.presentPokemonDetails(pokemon: pokemon, from: view)
        }
    }

    // MARK: - PokemonListInteractorDelegate

    func pokemonsDidFetch(pokemons: [PKMNamedAPIResource<PKMPokemon>]) {
        view.showPokemons(pokemons: pokemons)
    }

    func pokemonsFetchError() {
        
    }
}
