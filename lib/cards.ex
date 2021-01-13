defmodule Cards do
  @moduledoc """
    Cards
  """

  @doc """
    returns a list of strings representing a deck of  playing cards
  """
  def create_deck do
    values = ["ace", "two", "three", "four", "five"]
    suits = ["spades", "clubs", "hearts", "diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  determines whether a deck contains a given card



  ## examples

    iex> deck=Cards.create_deck
    iex> Cards.contain?(deck, "ace of spades")
    true
  """
  def contain?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    divides a deck into a hand and the remainder of the deck.
    the `hand_size` argument indicate how many cards should
    be in the hand.

  ## examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["ace of spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "that file does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
