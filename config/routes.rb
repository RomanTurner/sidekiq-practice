Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  resources :submissions
  resources :assignments
  resources :enrollments
  resources :students
  resources :courses
  resources :teachers
  resources :departments
end
