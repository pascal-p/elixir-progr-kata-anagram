defmodule KataAnagramTest do
  use ExUnit.Case

  doctest KataAnagram.Core

  import Expect

  setup_all do
    KataAnagram.Core.main("./resources/wordlist_test.txt")
  end

  expect "anagrams to be found"  do
    assert KataAnagram.Core.anagram_of("care") == "care anagram(s): acer acre race"

    assert KataAnagram.Core.anagram_of("organ") == "organ anagram(s): angor argon goran grano groan nagor orang rogan ronga"

  end

  expect "more anagrams to be found"  do
    assert KataAnagram.Core.anagram_of("carte") == "carte anagram(s): caret cater crate creat creta react recta"

    assert KataAnagram.Core.anagram_of("steer") == "steer anagram(s): ester estre reest stere stree terse tsere"
  end

  expect "anagram of pairs" do
    assert KataAnagram.Core.anagram?("race", "care")

    assert KataAnagram.Core.anagram?("terse", "reset")

    assert !KataAnagram.Core.anagram?("foo", "bar")
  end

  expect "anagram starting with a" do
    assert KataAnagram.Core.starting_with("a") == [["acer", "acre", "care", "race"],
                                                     ["angor", "argon", "goran", "grano", "groan", "nagor", "orang", "rogan", "ronga"]]
  end

end
