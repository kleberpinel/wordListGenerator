require 'nokogiri'
require 'open-uri'
require 'source'
require 'brazilian-rails'
require 'brI18n'

class WordListGeneratorController < ApplicationController
  
  @dups = nil
  
  def generate
    maxSource = 10
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
       puts "Erro ---[" + source.url + source.link + "]-->" + e.message  
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
           puts "Erro ---[" + source.url + link + "]-->" + e.message  
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
    
    nome_arquivo = RAILS_ROOT + '/public/wordList/arquivo.txt'
    puts nome_arquivo
    arquivo = File.open(nome_arquivo, 'wb')
    arquivo.puts @words
    arquivo.close
  end
  
  def getText(doc)
   
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

end
