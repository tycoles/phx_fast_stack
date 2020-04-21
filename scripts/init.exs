defmodule Init do
  @current_project_name "phx_fast_stack"
  @current_project_name_camel Macro.camelize(@current_project_name)

  def prompt() do
    IO.gets "Enter new project name in snake case format (ie. awesome_new_project):\n"
  end

  def do_replace(text_to_replace, replace_with) do
    System.cmd("sh", ["scripts/replace_file_contents.sh", text_to_replace, replace_with])
  end

  def replace_file_contents(new_project_name) do
    do_replace(@current_project_name, new_project_name)
    do_replace(@current_project_name_camel, Macro.camelize(new_project_name))
  end

  def rename_files(new_project_name) do
    System.cmd("sh", ["scripts/rename_files.sh", @current_project_name, new_project_name])
  end

  def run() do
    new_project_name = prompt() |> String.replace("\n", "")
    replace_file_contents(new_project_name)
    rename_files(new_project_name)
  end
end

Init.run()
