Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "projects#init"
  get "/projects" => "projects#all"
  post "/projects/init" => "projects#init"
  post "/todos" => "todos#create_one"
  patch "projects/:project_id/todo/:todo_id" => "todos#update_todo_value"
  
end
