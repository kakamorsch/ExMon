defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Status}
  @computer_name "Dilma"
  def create_player(name, move_avg, move_rnd, move_heal) do
    Player.build(name, move_avg, move_rnd, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:xingar, :mentir, :inflacionar)
    |> Game.start(player)

    Status.print_round_message()
  end

  def make_move(move) do
    Action.fetch_move(move)
  end
end
