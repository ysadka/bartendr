class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :ensure_feature_active

  def ensure_feature_active
    feature_dependency = self.class.instance_variable_get(:@feature_dependency)
    if feature_dependency
      not_found unless $rollout.active?(feature_dependency)
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def self.depends_on_feature(feature)
    @feature_dependency = feature
  end
end
