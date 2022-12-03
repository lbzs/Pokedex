//
//  PokemonDetailInteractor.swift
//  Pokedex
//
//  Created by Balint Lakatos on 03.12.2022.
//

import Foundation

import PokemonAPI

protocol PokemonDetailInteractorDelegate: AnyObject {
    func pokemonDidFetch(pokemon: PKMPokemon)
    func pokemonFetchError(error: Error)
}

final class PokemonDetailInteractor {

    weak var delegate: PokemonDetailInteractorDelegate?

    func fetchPokemonDetail(of pokemonName: String) {
        PokemonAPI().pokemonService.fetchPokemon(pokemonName) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case let .success(pokemon):
                self.delegate?.pokemonDidFetch(pokemon: pokemon)
            case let .failure(error):
                self.delegate?.pokemonFetchError(error: error)
            }
        }
    }
}
