class LandingController < ApplicationController
  def index
  end

  def phone
    render layout: "phone"
  end
end
