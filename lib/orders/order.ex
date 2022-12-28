defmodule Exlivery.Orders.Order do
  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  @keys [:user_cpf, :delivery_address, :items, :total_price]
  @enforce_keys @keys

  defstruct @keys

  def build(%User{cpf: cpf, address: address}, [%Item{} | _items] = items) do
    {:ok,
     %__MODULE__{
       user_cpf: cpf,
       delivery_address: address,
       items: items,
       total_price: items |> calculate_total_price()
     }}
  end

  def build(_users, _items), do: {:error, "Invalid parameters."}

  defp calculate_total_price(items) do
    items |> Enum.reduce(Decimal.new("0.00"), &sum_prices(&1, &2))
  end

  defp sum_prices(%Item{unit_price: price, quantity: quantity}, acc) do
    price
    |> Decimal.mult(quantity)
    |> Decimal.add(acc)
  end
end
