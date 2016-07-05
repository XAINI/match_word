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
    content = params[:content]
    aaa = params[:aaa]
    bbb = params[:bbb]
    ccc = params[:ccc]
    ddd = params[:ddd]
    correct = params[:correct]
    p "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    
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