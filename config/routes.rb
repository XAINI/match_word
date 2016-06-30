Rails.application.routes.draw do

  resources :match_word do
    post :insert, on: :collection
    get :react_code, on: :collection
    get :practice_d_three, on: :collection
  end

end
