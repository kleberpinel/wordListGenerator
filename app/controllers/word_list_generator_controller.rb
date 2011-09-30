require 'legal'

class WordListGeneratorController < ApplicationController
  
  def generate
    Resque.enqueue(Legal)
  end

end
