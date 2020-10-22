require "rails_helper"

RSpec.describe PostsController, type: :controller do

  describe "POST /" do
    it "responds with 200" do
      post :create, params: { post: { message: "Hello, world!" } }
      expect(response).to redirect_to(posts_url)
    end

    it "creates a post" do
      post :create, params: { post: { message: "Hello, world!" } }
      expect(Post.find_by(message: "Hello, world!")).to be
    end
  end

  describe "GET /" do
    it "responds with 200" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE /" do
    before :each do
      @post = Post.create(:message => :cat)
    end

    it "removes post from table" do
      expect { delete :destroy, params: { id: @post.id } }.to change { Post.count }.by(-1)
    end

    it "returns a status found (302)" do
      delete :destroy, params: { id: @post.id }
      expect(response).to have_http_status(302) #would like to check with someone that this is the desired response from a delete route
    end
  end

  describe "posts#update" do
    before :each do
      @post = Post.create(:message => "Hello Charlotte!")
    end

    it "Changes the message of a post" do
      patch :update, params: { id: @post.id, post: { message: "updated" } }
      @post = Post.find_by(id: @post.id)
      expect(Post.find_by(id: @post.id).message).to eq "updated"
    end
  end
end
