class CtfController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  BASE_PATH = Rails.root.join("app", "assets", "ctf", "writeups")
  CTF_INFO_PATH = Rails.root.join("app", "assets", "ctf", "ctfs.json")

  def sanitize_path(param)
    param.match?(/\A[\w\-]+\z/)
  end

  def index
    file = File.read(CTF_INFO_PATH)
    @ctfs = JSON.parse(file)
  end

  def which
    unless sanitize_path(params[:which])
      render plain: "Invalid ctf", status: :bad_request
      return
    end

    which_path = BASE_PATH.join(params[:which])
    ctf_info = File.read(which_path.join("writeups.json"))
    @ctf_info = JSON.parse(ctf_info)
    if Dir.exist?(which_path)
      @which = params[:which]
      @writeups = Dir.entries(which_path).select { |file| file.end_with?(".md") }.map { |file| file.sub(".md", "") }
    else
      render plain: "Ctf not found", status: :not_found
    end
  end

  def writeup
    unless sanitize_path(params[:which]) && sanitize_path(params[:writeup].gsub(".md", ""))
      render plain: "Invalid writeup", status: :bad_request
      return
    end

    file_path = BASE_PATH.join(params[:which], (params[:writeup] + ".md"))

    if file_path.exist? && file_path.file? && file_path.to_s.start_with?(BASE_PATH.to_s)
      @markdown_content = File.read(file_path)
    else
      @markdown_content = "Markdown file not found"
    end
    @which = params[:which]
    @writeup = params[:writeup]
  end
end
