# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ranker.Repo.insert!(%Ranker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Ranker.Repo
alias Ranker.PointTrading.Reward

Repo.insert!(%Reward{name: "One extra day of PTO"})

Repo.insert!(%Reward{name: "Any pizza up to 40 PLN"})
