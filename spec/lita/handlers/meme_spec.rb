require "spec_helper"

describe Lita::Handlers::Meme, lita_handler: true do
  it "returns list" do
    send_command("meme list")

    expect(replies.length).to eq(20)
  end

  # it "returns one does not" do
  #   send_command("one does not simply walk into mordor")
  # end
end
