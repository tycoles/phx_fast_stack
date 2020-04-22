defmodule Init do
  @current_project_name "phx_fast_stack"
  @current_project_name_camel Macro.camelize(@current_project_name)

  def clean_input(input) do
    String.replace(input, "\n", "")
  end

  def prompt_for_project_name() do
    IO.gets("Enter new project name in snake case format (ie. awesome_new_project): ")
      |> clean_input()
  end

  def prompt_for_new_url() do
    IO.gets("Enter new project url (ie. \"git@github.com:user/newrepo.git\"): ")
      |> clean_input()
  end

  def prompt_for_dep_installation() do
    IO.gets("Would you like to go ahead and install project dependencies? (node and elixir):[Y/n] ")
      |> clean_input()
  end

  def install_deps(answer) do
    if answer == "Y", do: System.cmd("sh", ["scripts/clean_install_deps.sh"])
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

  def set_new_origin_url(new_url) do
    System.cmd("git", ["remote", "set-url", "origin", new_url])
  end

  def run() do
    # Prompt for input
    new_project_name = prompt_for_project_name()
    new_project_url = prompt_for_new_url()
    install_deps_answer = prompt_for_dep_installation()

    # Run project reinit
    IO.puts "Replacing file contents..."
    replace_file_contents(new_project_name)

    IO.puts "Renaming files..."
    rename_files(new_project_name)

    IO.puts "Changing remote origin url..."
    set_new_origin_url(new_project_url)

    IO.puts "Cleaning/installing dependencies..."
    install_deps(install_deps_answer)
  end
end

Init.run()
