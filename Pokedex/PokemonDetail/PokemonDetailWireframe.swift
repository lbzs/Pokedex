//
//  PokemonDetailWireframe.swift
//  Pokedex
//
//  Created by Balint Lakatos on 03.12.2022.
//

import UIKit

protocol PokemonDetailWireframeProtocol: AnyObject {

    func makePokemonDetailViewController(pokemonName: String) -> UIViewController
    func viewDidDisappear()
}

final class PokemonDetailWireframe: PokemonDetailWireframeProtocol {

    private var pokemonDetailPresenter: PokemonDetailPresenter?

    func makePokemonDetailViewController(pokemonName: String) -> UIViewController {
        let pokemonDetailViewController = PokemonDetailViewController()
        let pokemonDetailInteractor = PokemonDetailInteractor()
        pokemonDetailPresenter = PokemonDetailPresenter(pokemonName: pokemonName, view: pokemonDetailViewController, interactor: pokemonDetailInteractor)
        pokemonDetailPresenter?.wireframe = self
        return pokemonDetailViewController
    }

    func viewDidDisappear() {
        pokemonDetailPresenter = nil
    }
}
