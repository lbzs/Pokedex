//
//  PokemonDetailPresenter.swift
//  Pokedex
//
//  Created by Balint Lakatos on 03.12.2022.
//

import Foundation

import PokemonAPI

enum PokemonDetailEvent {
    case updateView
    case viewDidDisappear
}

protocol PokemonDetailEventHandler: AnyObject {
    func handle(event: PokemonDetailEvent)
}

final class PokemonDetailPresenter: PokemonDetailEventHandler, PokemonDetailInteractorDelegate {

    weak var wireframe: PokemonDetailWireframeProtocol?

    private let pokemonName: String
    private let view: PokemonDetailProtocol
    private let interactor: PokemonDetailInteractor

    init(pokemonName: String, view: PokemonDetailProtocol, interactor: PokemonDetailInteractor) {
        self.pokemonName = pokemonName
        self.view = view
        self.interactor = interactor
        self.view.eventHandler = self
        self.interactor.delegate = self
    }

    // MARK: - PokemonDetailEventHandler

    func handle(event: PokemonDetailEvent) {
        switch event {
        case .updateView:
            interactor.fetchPokemonDetail(of: pokemonName)
        case .viewDidDisappear:
            wireframe?.viewDidDisappear()
        }
    }

    // MARK: - PokemonDetailInteractorDelegate

    func pokemonDidFetch(pokemon: PKMPokemon) {
        view.showPokemon(pokemon)
    }

    func pokemonFetchError(error: Error) {
        view.showError(error)
    }
}
