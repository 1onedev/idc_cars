class ApplicationController < ActionController::Base
  helper_method :to_ticker_post
  
  def to_ticker_post
    @to_ticker_post ||= Post.where(put_to_ticker: true).order(created_at: :desc).first
  end
end
