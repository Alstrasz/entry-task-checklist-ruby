class ProjectsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def all
        todos = Todo.pluck(:project_id, :id, :text, :isCompleted).group_by(&:shift)
        projects = Project.all
        ret = []
        for project in projects do
            project_to_insert = { id: project[:id], title: project[:title], todos: [] } 
            if todos.has_key?(project[:id]) then 
                for todo in todos[project[:id]] do
                    project_to_insert[:todos].push( { id: todo[0], text: todo[1], isCompleted: todo[2] } )
                end
            end

            ret.push(project_to_insert)
        end
        puts ret
        render json: ret
        # render json: { 'messages': 'ok'}
    end

    def init
        default_data = [
            { 
              title: 'Семья', 
              todos: [
                {
                  text: 'Купить молоко',
                  isCompleted: false
                },
                {
                  text: 'Заменить масло в двигателе до 23 апреля',
                  isCompleted: false
                },
                {
                  text: 'Отправить письмо бабушке',
                  isCompleted: true
                },
                {
                  text: 'Забрать обувь из ремонта',
                  isCompleted: false
                },
                {
                  text: 'Купить молоко',
                  isCompleted: false
                },
              ]
            }, 
            {
              title: 'Работа', 
              todos: [
                {
                  text: 'Позвонить заказчику',
                  isCompleted: true
                },
                {
                  text: 'Отправить документы',
                  isCompleted: true
                },
                {
                  text: 'Заполнить отчет',
                  isCompleted: false
                }  
              ]
            }, 
            {
              title: 'Прочее', 
              todos: [
                {
                  text: 'Позвонить другу',
                  isCompleted: false
                },
                {
                  text: 'Подготовиться к поездке',
                  isCompleted: false
                }    
              ]
            }
          ]
    
          for project in default_data do
            inserted_project = Project.find_or_create_by(title: project[:title])
            for todo in project[:todos] do
              inserted_todo = Todo.find_or_create_by(text: todo[:text], project_id: inserted_project[:id]).update_attribute(:isCompleted, todo[:isCompleted])
            end
          end
          render json: { 'messages': 'ok'}
    end
end

