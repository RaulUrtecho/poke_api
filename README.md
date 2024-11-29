# `poke_api` Package

A Dart package to interact with the [Pokémon API](https://pokeapi.co/). This package provides an easy-to-use interface for retrieving information about Pokémon and their attributes.

## Features

- Fetch Pokémon by name.
- Retrieve a list of Pokémon with pagination support.
- Handles API calls and errors gracefully.

## Installation

To use the `poke_api` package, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  poke_api: ^1.0.0
```
# Usage
1. Initialize the service
You can initialize the PokeApiService by optionally passing an HTTP client for custom configurations. If no client is provided, the default http.Client() will be used.

```dart
import 'package:poke_api/poke_api.dart';
import 'package:http/http.dart' as http;

final pokeApiService = PokeApiService(client: http.Client());
```
# Methods
`Future<Pokemon> getPokemonByName(String name)`

Fetches a Pokémon by its name.

- Arguments:

  - `name`: The name of the Pokémon (e.g., "pikachu").

 - Returns: A `Pokemon` object containing details of the Pokémon.

 - Throws: A `PokeApiException` if the request fails.

`Future<PokemonList> getPokemons(int start, {int? limit})`

Fetches a list of Pokémon starting from the given index, with an optional limit on the number of results.

- Arguments:

  - `start`: The index to start fetching Pokémon from (e.g., 0 for the first Pokémon).

  - `limit`: Optional. The maximum number of Pokémon to fetch (defaults to 10).

- Returns: A `PokemonList` object containing the Pokémon results.

- Throws: A `PokeApiException` if the request fails.
Error Handling

The package throws a `PokeApiException` if an API call fails (e.g., a 404 or 500 status code). Ensure to handle errors using try-catch blocks when calling the methods.

## License

This app is licensed under the [MIT License](LICENSE).