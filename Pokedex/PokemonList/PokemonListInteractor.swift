//
//  PokemonListInteractor.swift
//  Pokedex
//
//  Created by Balint Lakatos on 02.12.2022.
//

import PokemonAPI

protocol PokemonListInteractorDelegate: AnyObject {
    func pokemonsDidFetch(pokemons: [PKMNamedAPIResource<PKMPokemon>])
    func pokemonsFetchError(_ error: Error?)
}

final class PokemonListInteractor {

    weak var delegate: PokemonListInteractorDelegate?

    func fetchPokedex() {
        PokemonAPI().pokemonService.fetchPokemonList { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(pokemon):
                if let results = pokemon.results as? [PKMNamedAPIResource<PKMPokemon>] {
                    self.delegate?.pokemonsDidFetch(pokemons: results)
                } else {
                    self.delegate?.pokemonsFetchError(nil)
                }
            case let .failure(error):
                self.delegate?.pokemonsFetchError(error)
            }
        }
    }
}
