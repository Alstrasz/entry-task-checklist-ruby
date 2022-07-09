class ProjectsController < ApplicationController
    def all
        render json: { 'messages': 'ok'}
    end
end
