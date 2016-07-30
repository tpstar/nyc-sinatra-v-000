class FiguresController < ApplicationController

  get "/figures" do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post "/figures" do

    @figure = Figure.create(name: params[:figure][:name])

    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |title|
        @figure.titles << Title.find(title) unless @figure.titles.include?(Title.find(title))
      end
    end

    if !params[:title][:name].empty?
      @figure.titles << Title.create(name: params[:title][:name])
    end

    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |landmark|
        @figure.landmarks << Landmark.find(landmark) unless @figure.landmarks.include?(Landmark.find(landmark))
      end
    end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(name: params[:landmark][:name])
    end

    @figure.save
    redirect "figures/#{@figure.id}"
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    erb :"/figures/edit"
  end

  post "/figures/:id" do
    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]

    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |t|
        @figure.titles << Title.find(t) unless @figure.titles.include?(Title.find(t))
      end
    end

    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |l|
        @figure.landmarks << Landmark.find(l) unless @figure.landmarks.include?(Landmark.find(l))
      end
    end

    if !params["new_landmark"].empty?
      @figure.landmarks << Landmark.create(name: params["new_landmark"])
    end

    @figure.save
    redirect "figures/#{@figure.id}"
  end

end
