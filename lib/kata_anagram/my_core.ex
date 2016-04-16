defmodule KataAnagram.MyCore do
  require KataAnagram.Struct

  @moduledoc """
  Implementation of the anagram kata.
  input: a word list (utf-8),
  output:
  - a map of all the anagrams (anagram key, list of anagram for that key
  - a list of list of all the anagrams
  """

  @name __MODULE__

  @doc """
  our Agent is holding a list of of 2 elements: a map and a list
  anagrams = KataAnagram.Core.main, set up the state held by the agent

  ## Examples
    iex> KataAnagram.MyCore.main("./resources/s_wordlist.txt")
    :ok
  """
  def main(file \\ "./resources/s_wordlist.txt") do
    start_agent
    my_map = %{}
    my_map = File.stream!(file, [:read, :utf8], :line)
    |> Enum.filter_map(&exclude_non_word/1, &String.strip/1)
    |> Enum.map(&calculate_key/1)
    |> Enum.reduce(my_map, &add_to/2)
    my_list = to_list(my_map)
    Agent.update(@name,
      fn ds ->
        ds_update(ds, my_map, my_list)
      end)
  end

  #
  @doc """
  call KataAnagram.Core.anagram_of(word) returns a list (maybe empty) of
  anagrams of `word`

  """
  def anagram_of(word) do
    [key | _] = calculate_key(word)
    map = ds_get_map
    cond do
      Map.has_key?(map, key) ->
        "#{word} anagram(s): #{Enum.reject(map[key], fn(w) -> w == word end) |> Enum.join(" ")}"
      true ->
        "#{word} has no anagram"
    end
  end

  #
  # not really useful, just for the fun...
  #
  def starting_with(letter \\ "a") do
    ds_get_list
    |> Enum.filter(fn [h | _] -> Regex.match?(~r/^#{letter}/i, h) end)
  end


  @doc """

  ## Examples
    iex> KataAnagram.MyCore.anagram?("rate", "tare")
    true

    iex> KataAnagram.MyCore.anagram?("foo", "bar")
    false

  """
  def anagram?(word1, word2) do
    [key1, _] = calculate_key(word1)
    [key2, _] = calculate_key(word2)
    key1 == key2
  end

  def list do
    ds_get_list
  end

  def map do
    ds_get_map
  end

  # Private
  #
  # This function returns a list, eliminating singleton or empty list
  defp to_list(map) do
    map
    |> Dict.values
    |> Enum.filter(&reject_singleton_n_empty/1)
  end

  defp exclude_non_word(word) do
    !Regex.match?(~r/[\^']/i, word)
  end

  #
  # given a `word` this function returns a pair (list) [key, word]
  #
  defp calculate_key(word) do
    key = word |>
      String.downcase |>
      String.split("") |>
      List.delete("") |>
      Enum.sort |>
      List.to_string
    [key, String.downcase(word)]
  end

  #
  # update map[key] with word or init map[key] with [word]
  # returns [implicitely) new map
  #
  defp add_to([key | _], map) when key == "" do
    map
  end

  defp add_to([key | word], map) do
    cond do
      Map.has_key?(map, key) ->
        Map.put(map, key, Enum.concat(map[key], word))
      true -> Map.put_new(map, key, word)
    end
  end

  #
  # reject list of size < 1
  #
  defp reject_singleton_n_empty(list) do
    if Kernel.length(list) > 1 do
      l = list |>
        Enum.sort |>
        Enum.uniq
      # l = Enum.uniq(Enum.sort(list))
      if Kernel.length(l) > 1, do: l
    end
  end

  defp start_agent do
    Agent.start_link(&ds_init/0, name: @name)
  end

  #
  # the data-struct hold by the agent, a list composed of a map and a list
  #
  defp ds_init, do: %KataAnagram.Struct{}

  #
  # read-only access to data-struct
  #
  defp ds_get, do: Agent.get(@name, &(&1))

  defp ds_get_map, do: ds_get |> KataAnagram.Struct.get_map

  defp ds_get_list, do: ds_get |> KataAnagram.Struct.get_list

  defp ds_update(ds, map, list) do
    KataAnagram.Struct.set(ds, map, list)
  end

  defp ds_update(map, []), do: ds_get |> KataAnagram.Struct.set_map(map)

  defp ds_update(%{}, list), do: ds_get |> KataAnagram.Struct.set_list(list)

  defp ds_update(map, list), do: ds_get |> KataAnagram.Struct.set(map, list)

end
