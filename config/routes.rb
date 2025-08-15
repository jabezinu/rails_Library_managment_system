Rails.application.routes.draw do
  root "books#index"
  
  resources :categories
  resources :books do
    member do
      post :borrow
    end
  end
  resources :students
  resources :borrowings, only: [:index, :show, :new, :create] do
    member do
      patch :return_book
    end
  end
  
  # Additional routes for library management
  get "out_of_stock_books", to: "books#out_of_stock"
  get "active_borrowings", to: "borrowings#active"
  get "borrowing_history", to: "borrowings#history"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end