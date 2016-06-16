Rails.application.routes.draw do

  resources :match_word do
    post :insert, on: :collection
  end

end
