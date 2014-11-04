class TweetBookSettingsController < ApplicationController
  unloadable
  before_filter :find_project_by_project_id, :authorize

  def save
    if params[:tweet_book_settings] && params[:tweet_book_settings].is_a?(Hash) then
      settings = params[:tweet_book_settings]
      settings.map do |k, v|
        TweetBookSetting[k, @project.id] = v
      end
    end
    redirect_to :controller => 'projects', :action => 'settings', :id => @project, :tab => params[:tab]
  end

end
