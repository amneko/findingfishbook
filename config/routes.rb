Rails.application.routes.draw do
  get 'top_pages/top'
  root 'top_pages#top'
end
