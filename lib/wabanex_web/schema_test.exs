defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is givren, returns the user", %(conn: conn) do
      params = %{email: "rafael@banana.com", name: "Rafael", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
      {
        getUser(id: "#(user_id)"){
          id
          name
          email
        }
      }
      """

      response =
        conn
        |> post("api/graphql", %{query: query})
        |> json_response(:ok)

        expected_response = %{
          "data" => %{
            "getUser" => %{
              email: "rafael@banana.com",
              name: "Rafael"
            }
          }
        }

        assert response == expected_response
    end

    describe "users mutations" do
      test "when all params are valid, creates the user", %(conn: conn) do

        mutation = """
          mutation {
            createUser(input: {
              name: "Joao", email: "joao@banana.com", password: "123456"
            }){
            id
            name
            }
          }
          """

          response =
            conn
            |> post("api/graphql", %{query: mutation})
            |> json_response(:ok)

        assert %{data => %{"createUser" => %{"id" => id, "name" => "Joao"}}} = response
      end
    end
  end
end
