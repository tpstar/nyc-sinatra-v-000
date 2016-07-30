class LandmarksController < ApplicationController

  get "/landmarks" do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

  post "/landmarks" do

    @landmark = Landmark.create(name: params[:landmark][:name])
    @landmark.year_completed = params[:landmark][:year_completed]

    if params[:landmark][:figure_ids]
      params[:landmark][:figure_ids].each do |figure|
        @landmark.figure = Landmark.find(figure) #unless @landmark.figures.include?(Landmark.find(figure))
      end
    end

    if !params[:figure][:name].empty?
      @landmark.figure = Landmark.create(name: params[:figure][:name])
    end

    @landmark.save
    redirect "landmarks/#{@landmark.id}"
  end

  get "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/show'
  end

  get "/landmarks/:id/edit" do
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/edit"
  end

  post "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    @landmark.name = params[:landmark][:name]
    @landmark.year_completed = params[:landmark][:year_completed]

    if params[:landmark][:figure_ids]
      params[:landmark][:figure_ids].each do |f|
        @landmark.figure = Figure.find(f) #unless @landmark.figures.include?(Landmark.find(t))
      end
    end


    if !params["new_figure"].empty?
      @landmark.figure = Figure.create(name: params["new_figure"])
    end

    @landmark.save
    redirect "landmarks/#{@landmark.id}"
  end


end
