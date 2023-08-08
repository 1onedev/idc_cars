class Admin::Ajax::ModelsController < Admin::BaseController
  layout false

  def index
    if params[:mark_id].present?
      @models = Model.where(mark_id: params[:mark_id]).order(name: :asc)
    else
      @models = Model.none
    end
  end
end
