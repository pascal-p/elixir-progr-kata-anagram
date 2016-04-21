# KataAnagram

A first try with Elixir.
  This programs computes all the anagrams from a given dictionnary. It then exposes
  some functions to
  - check if two words are anagrams,
  - to list the anagrams
  - ...

## TODO
  command line interface + test
  packaging

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add kata_anagram to your list of dependencies in `mix.exs`:

        def deps do
          [{:kata_anagram, "~> 0.0.1"}]
        end

  2. Ensure kata_anagram is started before your application:

        def application do
          [applications: [:kata_anagram]]
        end

