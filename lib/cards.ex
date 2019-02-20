defmodule Cards do
  @moduledoc """
  Provides functions for creating & handling a deck of cards
  """
  @doc """
    Returns a list of strings representing a list of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three","Four", "Five", "Six","Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King" ]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    #Comprehension
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end


  def shuffle(deck) do
    Enum.shuffle(deck)
  end


  @doc """
  Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides a deck into a hand. The remainder, `hand_size` argument specifies how many cards are being dealt.

  ## Examples
      
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 5)
      iex> hand
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades", "Five of Spades"]
    
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
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
