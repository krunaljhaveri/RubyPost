require 'spec_helper'

describe PostsController do

  describe 'GET /posts' do

    it 'populates an array of posts' do
      post = stub_model(Post)
      Post.stub(:all) { [post] }
      get :index
      assigns(:posts).should eq([post])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end

  end

  describe "GET /posts/:id" do

    it "assigns the requested post to @post" do
      post = stub_model(Post)
      Post.stub(:find) { post }
      get :show, id: post
      assigns(:post).should eq(post)
    end

    it "renders the #show view" do
      post = stub_model(Post)
      Post.stub(:find) { post }
      get :show, id: post
      response.should render_template :show
    end
  end

end
