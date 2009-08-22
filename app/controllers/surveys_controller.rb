class SurveysController < ApplicationController
  
  make_resourceful do
    actions :new #, :create, :edit, :update
  end
  
end
