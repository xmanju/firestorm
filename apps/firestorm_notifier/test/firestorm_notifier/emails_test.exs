defmodule FirestormNotifier.EmailsTest do
  use ExUnit.Case
  import Bamboo.Email
  alias FirestormNotifier.Emails

  test "thread new post notifications have appropriate reply-to" do
    user = %{email: "bob@example.com"}
    thread = %{title: "Some thread", id: "123"}
    post = %{}
    email = Emails.thread_new_post_notification(user, thread, post)
    assert email.headers["Reply-To"] == "reply-thread-123@notifier.firestormforum.org"
  end
end