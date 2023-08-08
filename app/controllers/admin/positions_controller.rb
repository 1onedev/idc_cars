class Admin::PositionsController < Admin::BaseController
  def update
    result = ::UpdatePositions.call(
      resource: positions_params[:resource],
      positions: positions_params[:positions],
      attribute: positions_params[:resource_attribute]
    )

    if result.success?
      flash[:success] = 'Данные сохранены'
      render js: "window.location = '#{params[:redirect_url]}'"
    else
      flash[:error] = 'Ошибка.'
      render js: "window.location = '#{params[:redirect_url]}'"
    end
  end

  private

  def positions_params
    @positions_params ||= params.to_unsafe_h
  end
end
