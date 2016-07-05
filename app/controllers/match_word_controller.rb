require 'tempfile'
require 'open-uri'
require 'net/http'
class MatchWordController < ApplicationController
  def index
    
  end

  def insert
    fetch_value = params[:fetched_value]
    word_list = RegExp_split_words(fetch_value)
    
    word_list.each do |word|
      data = MatchWord.create(:word => word)
    end
  end

  def practice_d_three
    
  end

  def react_code
    @component_data = {
      comments: [
        {
          content: "Hello China",
          creator: "Obama"
        },
        {
          content: "同志们好！",
          creator: "习近平"
        }
      ],

      comments_url: ""

    }
  end

  def insert_question
    
  end

  def insert_into_question
    single_question_result = params[:single_quesiton]
    multi_question_result = params[:multi_question]
    single_file_path = "public/单选题.json"
    multi_file_path = "public/多选题.json"
    single_file = File.new(single_file_path, 'wb+')
    multi_file = File.new(multi_file_path, 'wb+')
    single_file.write(single_question_result.to_json)
    multi_file.write(multi_question_result.to_json)
    single_file.close
    multi_file.close
  end


  private
    def RegExp_split_words(str)
      data = []
      pattern = /^[a-zA-Z]+/
      items = str.scan(pattern)
      items.each_with_index do |item|
        data.push(item)
      end
      data
    end
end