require 'rails_helper'

describe BlogsController, type: :controller do
  before :each do
    user = sign_in (create :admin)
    @iteration = create :iteration
  end

  describe "when getting blog index" do
    it "responds with success" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "loads all blogs into @blogs" do
      blogs = create_list(:blog, 10, iteration: @iteration)
      get :index
      expect(assigns(:blogs)).to match_array(blogs)
    end
  end

  describe "when creating a blog" do
    it "accesses the new blog page as superartist" do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)      
    end
    it "saves the blog" do
      blog = build :blog
      expect {
        post :create, params: {blog: blog.attributes}
      }.to change {Blog.count}.by 1
    end
    it "associates new blog with current iteration" do
      iter = create :iteration
      blog = build :blog, :iteration => nil
      post :create, params: {blog: blog.attributes}
      blog = Blog.last
      expect(blog.iteration_id).to eq iter.id
    end
    it "responds with redirect" do
      blog = build :blog
      post :create, params: {blog: blog.attributes}
      expect(response).to be_redirect
    end
    it "does not work for non-superartist" do
      user = sign_in (create :steerer)
      blog = build :blog
      expect {
        post :create, params: {blog: blog.attributes}
      }.to_not change {Blog.count}
    end
  end

  describe "when viewing a blog post" do
    it "render an existing blog" do
      blog = build :blog
      post :create, params: {blog: blog.attributes}
      blog = Blog.last
      get :show, id: blog.id
      response.should render_template :show 
    end
    ##
    #it "redirect at nonexistant blogs" do
    #  expect{ 
    #    get :show, id: nil
    #  }.to raise_error
    #  expect(flash[:error]).to be_present
    #end

  end

  describe "when updating a blog" do
    it "can update the title" do
      blog = create :blog
      put :update, params: {id: blog, blog: {:title => 'Hello, World!'}}
      blog.reload
      expect(blog.title).to eq 'Hello, World!'
    end
    it "responds with redirect" do
      blog = create :blog
      put :update, params: {id: blog, blog: {:title => 'Hello, World!'}}
      expect(response).to be_redirect
    end
    it "works for owner" do
      artist = create :super_artist
      user = sign_in (artist)
      blog = create :blog, user: artist
      put :update, params: {id: blog, blog: {:title => 'Hello, World!'}}
      blog.reload
      expect(blog.title).to eq 'Hello, World!'
    end
    it "does not work for non-owner" do
      user = sign_in (create :resident)
      blog = create :blog
      put :update, params: {id: blog, blog: {:title => 'Hello, World!'}}
      blog.reload
      expect(blog.title).to_not eq 'Hello, World!'
    end
  end

  describe "when deleting a blog" do
    it "removes it" do
      blog = create :blog
      expect {
        delete :destroy, params: {id: blog.id}
      }.to change {Blog.count}.by -1
    end
    it "responds with redirect" do
      blog = create :blog
      delete :destroy, params: {id: blog.id}
      expect(response).to be_redirect
    end
    it "works for owner" do
      artist = create :super_artist
      user = sign_in (artist)
      blog = create :blog, user: artist
      expect {
        delete :destroy, params: {id: blog.id}
      }.to change {Blog.count}.by -1
    end
    it "does not work for non-owner" do
      user = sign_in (create :resident)
      blog = create :blog
      expect {
        delete :destroy, params: {id: blog.id}
      }.to_not change {Blog.count}
    end
  end
end
