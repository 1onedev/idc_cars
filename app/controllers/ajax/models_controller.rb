class Ajax::ModelsController < ApplicationController
  layout false

  def index
    if params[:mark_id].blank?
      @filter_models = Model.none
    else
      mark = Mark.friendly.find(params[:mark_id])
      @filter_models = mark.models.with_cars.order(name: :asc)
    end
  end
end
