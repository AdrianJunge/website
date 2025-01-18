class LandingController < ApplicationController
  def index; end

  def ctf
    render partial: "ctf"
  end

  def bug_bounty
    render partial: "bug_bounty"
  end

  def cv
    render partial: "cv"
  end

  def minigames
    render partial: "minigames"
  end

  def tools
    render partial: "tools"
  end

  def blog
    render partial: "blog"
  end
end
