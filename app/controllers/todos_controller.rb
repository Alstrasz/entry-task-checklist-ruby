class TodosController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create_one
        project = Project.find_or_create_by(title: params[:title])
        Todo.find_or_create_by(text: params[:text], project_id: project[:id]).update_attribute(:isCompleted, false)
        puts project[:id], project[:title]
        todos = Todo.where(project_id: project[:id])

        project_to_return = { id: project[:id], title: project[:title], todos: [] } 
        for todo in todos do
            project_to_return[:todos].push( { id: todo[:id], text: todo[:text], isCompleted: todo[:isCompleted] } )
        end

        render json: project_to_return
    end

    def update_todo_value
        # Todo.find_or_create_by(id: params[:todo_id], project_id: params[:project_id]).update_attribute(:isCompleted, params[:new_value])
        # todo = Todo.update(params[:todo_id], { isCompleted: params[:new_value]})
        # render json: { id: todo[:id], text: todo[:text], isCompleted: todo[:isCompleted] }
        updated = Todo.where(id: params[:todo_id], project_id: params[:project_id]).update_all(isCompleted: params[:new_value])
        if updated > 0 then
            head 200
        else
            head 400
        end
    end
end
