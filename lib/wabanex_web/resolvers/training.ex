defmodule WabanexWeb.Resolvers.Training do
  def create(%{input: params}, context), do: Wabanex.Trainings.Create.call(params)
end
