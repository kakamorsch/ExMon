defmodule ExMonTest do
  use ExUnit.Case
  alias ExMon.Player

  import ExUnit.CaptureIO

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{
          move_avg: :soco,
          move_heal: :cura,
          move_rnd: :chute
        },
        name: "Kaio"
      }

      assert ExMon.create_player("Kaio", :soco, :chute, :cura) == expected_response
    end
  end

  describe "start_game/1" do
    test "when the game is started, returns a message" do
      player = Player.build("Kaio", :soco, :chute, :cura)

      messages =
        capture_io(fn ->
          assert ExMon.start_game(player) == :ok
        end)

      assert messages =~ "The game has began"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Kaio", :soco, :chute, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "the function receive a valid move and try to execute it" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert messages =~ "The player attacked the computer"
      assert messages =~ "It's computer turn"
      assert messages =~ "It's player turn"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid it will return an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert messages =~ "Invalid move: wrong"
    end
  end
end
