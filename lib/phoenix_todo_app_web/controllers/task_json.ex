defmodule PhoenixTodoAppWeb.TaskJSON do
  alias PhoenixTodoApp.Todo.Task

  @doc """
  Renders a list of todo_tasks.
  """
  def index(%{todo_tasks: todo_tasks}) do
    %{data: for(task <- todo_tasks, do: data(task))}
  end

  @doc """
  Renders a single task.
  """
  def show(%{task: task}) do
    %{data: data(task)}
  end

  defp data(%Task{} = task) do
    %{
      id: task.id,
      content: task.content,
      state: task.state
    }
  end
end
