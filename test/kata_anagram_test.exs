defmodule KataAnagramTest do
  use ExUnit.Case

  doctest KataAnagram.MyCore

  import Expect

  setup_all do
    KataAnagram.MyCore.main("./resources/s_wordlist.txt")
  end

  expect "anagrams to be found"  do
    assert KataAnagram.MyCore.anagram_of("care") == "care anagram(s): acer acre race"

    assert KataAnagram.MyCore.anagram_of("organ") == "organ anagram(s): angor argon goran grano groan nagor orang rogan ronga"

  end

  expect "more anagrams to be found"  do
    assert KataAnagram.MyCore.anagram_of("carte") == "carte anagram(s): caret cater crate creat creta react recta"

    assert KataAnagram.MyCore.anagram_of("steer") == "steer anagram(s): ester estre reest stere stree terse tsere"
  end

  expect "anagram of pairs" do
    assert KataAnagram.MyCore.anagram?("race", "care")

    assert KataAnagram.MyCore.anagram?("terse", "reset")

    assert !KataAnagram.MyCore.anagram?("foo", "bar")
  end

  expect "anagram starting with a" do
    assert KataAnagram.MyCore.starting_with("a") == [["acer", "acre", "care", "race"],
                                                     ["angor", "argon", "goran", "grano", "groan", "nagor", "orang", "rogan", "ronga"]]
  end

end
