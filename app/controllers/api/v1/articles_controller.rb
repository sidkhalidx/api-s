module Api
    module V1
        class ArticlesController < ApplicationController
            APP_ID = '123456'
            def index
                @articles = Article.order('created_at DESC')
                if params[:appid] == APP_ID
                    render json: {
                        status: 'SUCCESS',
                        message: 'Loaded articles',
                        data: @articles
                    }
                end
            end

            def show
                @article = Article.find(params[:id])
                if params[:appid] == APP_ID
                    render json: {
                        status: 'SUCCESS',
                        message: 'Article Loaded',
                        data: @article
                    }
                end
            end

            def create
                @article = Article.new(params.permit(:title, :body))
                if params[:appid] == APP_ID
                    if @article.save
                        render json: {
                            status: 'SUCCESS',
                            message: 'Article save',
                            data: @article
                        }
                    else
                        render json: {
                            status: 'Error',
                            message: 'Article not save',
                            data: @article.errors.full_messages
                        }
                    end
                else
                    render json: {
                        status: 'Error',
                        message: 'Auth error',
                        data: @article.errors.full_messages
                    }
                end
            end
            

            def update
                @article = Article.find(params[:id])
                if params[:appid] == APP_ID
                    if @article.update(params.permit(:title, :body))
                        render json: {
                            status: 'SUCCESS',
                            message: 'Article save',
                            data: @article
                        }
                    end
                else
                    render json: {
                        status: 'Error',
                        message: 'Auth error',
                        data: @article.errors.full_messages
                    }
                end
            end

            def destroy
                @article = Article.find(params[:id])
                if params[:appid] == APP_ID
                    if @article.delete
                        render json: {
                            status: 'SUCCESS',
                            message: 'Article deleted',
                        }
                    end
                else
                    render json: {
                        status: 'Error',
                        message: 'Auth error',
                        data: @article.errors.full_messages
                    }
                end
            end
        end
    end
end