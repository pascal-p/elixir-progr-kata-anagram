defmodule KataAnagram.Struct do

  defstruct map: %{}, list: []

  def get_map(ds = %KataAnagram.Struct{}) do
    ds.map
  end

  def get_list(ds = %KataAnagram.Struct{}) do
    ds.list
  end

  def set_list(ds = %KataAnagram.Struct{}, list) do
    %KataAnagram.Struct{ ds | list: list}
  end

  def set_map(ds = %KataAnagram.Struct{}, map) do
    %KataAnagram.Struct{ ds | map: map}
  end

  def set(_, map \\ %{}, list \\ [])

  def set(ds = %KataAnagram.Struct{}, map, list) when map == %{} do
    set_list(ds, list)
  end

  def set(ds = %KataAnagram.Struct{}, map, list) when list == [] do
    set_map(ds, map)
  end

  def set(ds = %KataAnagram.Struct{}, map, list) do
    %KataAnagram.Struct{ ds | map: map, list: list}
  end

end

# ds1 = %KataAnagram.Struct{map: %{foo: 'bar'}, list: [1,2,3,4,5] }
# %KataAnagram.Struct{list: [1, 2, 3, 4, 5], map: %{foo: 'bar'}}
#
# KataAnagram.Struct.get_list(ds1)
# [1, 2, 3, 4, 5]
#
# ds2 = KataAnagram.Struct.set_list(ds1, [2,4,6])
# %KataAnagram.Struct{list: [2, 4, 6], map: %{foo: 'bar'}}
