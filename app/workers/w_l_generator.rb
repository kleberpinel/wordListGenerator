require 'nokogiri'
require 'open-uri'
require 'source'
require 'brazilian-rails'
require 'brI18n'
require 'aws/s3'

class WLGenerator
  @queue = :w_l_generator
  
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
    Rails.logger.info "Processamento incializado!"
    @sources = Source.all
    @words = ""
    @dups = Set.new
    @linksUsed = Set.new

    @sources.each do |source|
      dupsBySource = Set.new
      i = 0
      @linksUsed.add(source.url + source.link)
      doc = Nokogiri::HTML(open(source.url + source.link), nil, 'UTF-8')
      begin
        dupsBySource = getText(doc)
      rescue Exception => e
       Rails.logger.info "Erro ---[" + source.url + source.link + "]-->" + e.message  
      end
      
      l = doc.css('p a').map { |link| link['href'] }
      l.each do |link|

        if( i < source.qtdSubPage )
        #if( i < 0 )
          @linksUsed.add(source.url + link)
          doc = Nokogiri::HTML(open(source.url + link), nil, 'UTF-8')
          begin
            dupsBySource = getText(doc)
          rescue Exception => e
           Rails.logger.info "Erro ---[" + source.url + link + "]-->" + e.message  
          end
          i = i +1
        end
      end
      source.words = dupsBySource.size
      source.save
    end

    @dups.each do |obj|
      @words += "#{obj};"
    end 

    AWS::S3::Base.establish_connection!(
      :access_key_id     => ENV['S3_KEY'] || 'AKIAJ7ZNS42OYFZPC3LA',
      :secret_access_key => ENV['S3_SECRET'] || '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'
    )
    AWS::S3::S3Object.store('arquivo.txt', @words , 'rails_s3', :access => :public_read)
    
    Rails.logger.info "Processamento finalizado!"
  end
  
  
end
