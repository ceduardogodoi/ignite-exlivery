defmodule Exlivery.Orders.Item do
  @categories [:pizza, :hamburger, :carne, :prato_feito, :japonesa, :sobremesa]

  @keys [:description, :category, :unit_price, :quantity]
  @enforce_keys @keys

  defstruct @keys

  def build(description, category, unit_price, quantity)
      when quantity > 0 and category in @categories do
    {:ok,
     %__MODULE__{
       description: description,
       category: category,
       unit_price: unit_price,
       quantity: quantity
     }}
  end

  def build(_description, _category, _unit_price, _quantity) do
    {:error, "Invalid parameters."}
  end
end
