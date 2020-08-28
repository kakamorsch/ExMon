defmodule ExMon.GameTest do
  use ExUnit.Case
  alias ExMon.{Game, Player}
  alias ExMon.Game.Status

  describe "start/2" do
    test "starts the game state" do
      player = Player.build("Kaio", :soco, :chute, :cura)
      computer = Player.build("Jotaro", :muda, :ore, :ara)

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      player = Player.build("Kaio", :soco, :chute, :cura)
      computer = Player.build("Jotaro", :muda, :ore, :ara)
      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :muda, move_heal: :ara, move_rnd: :ore},
          name: "Jotaro"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Kaio"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "updates the game info" do
      player = Player.build("Kaio", :soco, :chute, :cura)
      computer = Player.build("Jotaro", :muda, :ore, :ara)
      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :muda, move_heal: :ara, move_rnd: :ore},
          name: "Jotaro"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Kaio"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 35,
          moves: %{move_avg: :muda, move_heal: :ara, move_rnd: :ore},
          name: "Jotaro"
        },
        player: %Player{
          life: 10,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Kaio"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}
      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns the player state" do
      player = Player.build("Kaio", :soco, :chute, :cura)
      computer = Player.build("Jotaro", :muda, :ore, :ara)
      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :muda, move_heal: :ara, move_rnd: :ore},
          name: "Jotaro"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Kaio"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      expected_response = %ExMon.Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "Kaio"
      }

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "return whom turns it is" do
      player = Player.build("Kaio", :soco, :chute, :cura)
      computer = Player.build("Jotaro", :muda, :ore, :ara)
      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :muda, move_heal: :ara, move_rnd: :ore},
          name: "Jotaro"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Kaio"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      assert Game.turn() == :player
    end
  end

  describe "fetch_player/0" do
    test "fetch the passed player data" do
      player = Player.build("Kaio", :soco, :chute, :cura)
      computer = Player.build("Jotaro", :muda, :ore, :ara)
      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :muda, move_heal: :ara, move_rnd: :ore},
          name: "Jotaro"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Kaio"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      assert %ExMon.Player{
               life: 100,
               moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
               name: "Kaio"
             } == Game.fetch_player(:player)
    end
  end
end
