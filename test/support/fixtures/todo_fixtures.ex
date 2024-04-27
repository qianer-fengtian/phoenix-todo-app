defmodule PhoenixTodoApp.TodoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixTodoApp.Todo` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        content: "some content",
        state: 42
      })
      |> PhoenixTodoApp.Todo.create_task()

    task
  end
end
