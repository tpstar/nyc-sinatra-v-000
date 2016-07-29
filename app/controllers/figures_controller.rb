class FiguresController < ApplicationController

  get "/figures" do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post "/figures" do

#    binding.pry

    @figure = Figure.create(params[:figure])#(name: params[:figure][:name])

    # params[:figure][:title_ids].each do |title|
    #   @figure.titles << Title.find(title)
    # end

    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title][:name])
    end

    # params[:figure][:landmark_ids].each do |landmark|
    #   @figure.landmarks << Landmark.find(landmark)
    # end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end

    @figure.save

    redirect "figures/#{@figure.id}"
  end

  get "/figures/:id" do
#    binding.pry
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get "/figures/:id/edit" do
#    binding.pry
    @figure = Figure.find(params[:id])
    erb :"/figures/edit"
  end

  post "/figures/:id" do
    binding.pry
    @figure = Figure.find(params[:id])
    @figure.name = Figure.find_or_create_by(name: params[:figure][:name])

    params[:figure][:title_ids].each do |t|
      @figure.titles << Title.find(t)
    end

    params[:figure][:landmark_ids].each do |l|
      @figure.landmarks << Landmark.find(l)
    end

    if !params["new_landmark"].empty?
      @figure.landmarks << Landmark.create(name: params["new_landmark"])
    end

    @figure.save

    redirect "figures/#{@figure.id}"
  end

end
