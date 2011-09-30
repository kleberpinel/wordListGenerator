require 'w_l_generator'

class WordListGeneratorController < ApplicationController
  
  def generate
    Resque.enqueue(Legal)
  end

end
