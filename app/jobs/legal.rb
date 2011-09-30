require 'nokogiri'
require 'open-uri'
require 'source'
require 'brazilian-rails'
require 'brI18n'
require 'aws/s3'

class Legal
  @queue = :legal_queue
  
  def self.getText(doc)
    dupsBySource = Set.new
    doc.xpath('//p').each do | method_p |  
        array = method_p.content
          .remover_acentos
          .upcase
          .gsub('(', '')
          .gsub(')', '')
          .gsub('[', '')
          .gsub(']', '')
          .gsub(':', '')
          .gsub(',', '')
          .gsub('.', '')
          .gsub('.', '')
          .gsub('"', '')
          .gsub('\"', '')
          .gsub(/[^A-Za-z]\s/, '')
          .gsub(/[0-9]/, "").split(' ')
        array.each do |word|
          cleaned = ""
          word.each_byte { |x|  cleaned << x unless x > 127   }
          word = cleaned
          if(!(word == "") && (!word.include? "-") && (word.size >= 4) && (word.size <= 8))
            dupsBySource.add(word) 
            @dups.add(word)
          end
        end
    end
    return dupsBySource
  end
  
  def self.perform()
    @log = Log.new(:execution_date => Time.new)
    @log.urls = ""
    
    
    
    @log.number_of_words = 5
    @log.final_execution_date = Time.new
    @log.save
    
    Rails.logger.info "Processamento finalizado!"
  end
  
  
end
