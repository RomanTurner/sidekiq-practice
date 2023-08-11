Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  resources :submissions
  resources :assignments
  resources :enrollments
  resources :students do
    member { get "example", to: "students/example#pure_sidekiq_job" }
  end
  resources :courses
  resources :teachers
  resources :departments
end
