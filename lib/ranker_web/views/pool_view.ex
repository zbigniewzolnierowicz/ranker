defmodule RankerWeb.PoolView do
  use RankerWeb, :view
  alias Ranker.PointTrading.Pool

  def render("pool.json", %{pool: %Pool{} = pool}) do
    %{month: pool.month,
      year: pool.year,
      points: pool.points}
  end
end
