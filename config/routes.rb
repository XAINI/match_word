Rails.application.routes.draw do

  resources :match_word do
    post :insert, on: :collection
    get :react_code, on: :collection
    get :practice_d_three, on: :collection
    get :insert_question, on: :collection
    post :insert_into_question, on: :collection
  end

end
