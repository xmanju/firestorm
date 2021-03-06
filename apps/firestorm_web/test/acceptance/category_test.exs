defmodule FirestormWeb.Acceptance.CategoryTest do
  @moduledoc false
  use FirestormWeb.AcceptanceCase, async: true

  describe "when authenticated" do
    setup [:create_user, :create_categories]

    test "can view a category", %{session: session, user: user, elixir: elixir} do
      session
      |> log_in_as(user)
      |> visit(category_path(Endpoint, :show, elixir.slug))

      assert has?(session, Query.css(".category-header", text: elixir.title))
    end

    test "can tag a category", %{session: session, user: user, elixir: elixir} do
      form = Query.css(".tag-form")
      title_field = Query.css(".title")
      button = Query.css("button")
      add_tag = Query.css(".add-tag")

      session =
        session
        |> log_in_as(user)
        |> visit(category_path(Endpoint, :show, elixir.slug))

      # wait for js to run, sorry!
      :timer.sleep(1_000)

      session
      |> click(add_tag)
      |> find(form, fn(form) ->
        form
        |> fill_in(title_field, with: "functional-programming")
        |> click(button)
      end)

      # wait for js to run, sorry!
      :timer.sleep(1_000)

      assert has?(session, Query.css(".category-header", text: elixir.title))
      assert has?(session, Query.css(".tag-list .tag", text: "functional-programming"))
    end
  end
end
