Rails.application.routes.draw do
  # get 'top' => "homes#top"
  root to: 'homes#top'
  # For details on the D
  resources :books
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'
end
