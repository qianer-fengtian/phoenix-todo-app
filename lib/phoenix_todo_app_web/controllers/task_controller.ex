defmodule PhoenixTodoAppWeb.TaskController do
  use PhoenixTodoAppWeb, :controller

  alias PhoenixTodoApp.Todo
  alias PhoenixTodoApp.Todo.Task

  action_fallback PhoenixTodoAppWeb.FallbackController

  def index(conn, _params) do
    todo_tasks = Todo.list_todo_tasks()
    render(conn, :index, todo_tasks: todo_tasks)
  end

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- Todo.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/todo_tasks/#{task}")
      |> render(:show, task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Todo.get_task!(id)
    render(conn, :show, task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Todo.get_task!(id)

    with {:ok, %Task{} = task} <- Todo.update_task(task, task_params) do
      render(conn, :show, task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Todo.get_task!(id)

    with {:ok, %Task{}} <- Todo.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
