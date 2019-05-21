module Api
  class PostsController < ApplicationController
    def index
      render json: { posts: Post.all }
    end
  end
end
