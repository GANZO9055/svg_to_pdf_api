# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    render "home/index", format: [:html]
  end
end
