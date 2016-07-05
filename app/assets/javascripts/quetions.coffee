class SaveQuestion
  constructor: (@$eml)->
    @bind_event()

  RegExp_delet_s: (desc)->
    match_result = desc.replace(/\s+/g,'')
    match_result

  RegExp_delet_letter: (choice)->
    match_result = choice.replace(/\w.+?\s+/g,'')
    match_result

  # desc multi_choice  choices[0..4] answer 
  bind_event:->
    @$eml.on "click", ".submit-question .convert-to-form",=>
      questions_single = []
      questions_multi = []
      input = jQuery(".input textarea").val()
      input_to_json = JSON.parse(input)
      for ele in input_to_json.questions
        if ele.choices != null
          match_result = @RegExp_delet_s(ele.desc)
          match_letter = @RegExp_delet_letter(ele.choices[0])
          if ele.multi_choice == false
            chois_answer = ""
            for chois in ele.choices
              if chois.indexOf(ele.answer) == 0
                if chois.indexOf("A") == 0
                  chois_answer = "aaa"
                if chois.indexOf("B") == 0
                  chois_answer = "bbb"
                if chois.indexOf("C") == 0
                  chois_answer = "ccc"
                if chois.indexOf("D") == 0
                  chois_answer = "ddd"
                
            question = {
              "kind": "single_choice",
              "content": match_result
              "answer": {
                "choices": [{
                  "id": "aaa",
                  "text": @RegExp_delet_letter(ele.choices[0])
                }, {
                  "id": "bbb",
                  "text": @RegExp_delet_letter(ele.choices[1])
                }, {
                  "id": "ccc",
                  "text": @RegExp_delet_letter(ele.choices[2])
                }, {
                  "id": "ddd",
                  "text": @RegExp_delet_letter(ele.choices[3])
                }],
                "correct": chois_answer
              }
            }
            questions_single.push(question)
          if ele.multi_choice == true
            answers = []
            for answer in ele.answer
              if answer != ","
                if answer == "A"
                  answers.push("aaa")
                if answer == "B"
                  answers.push("bbb")
                if answer == "C"
                  answers.push("ccc")
                if answer == "D"
                  answers.push("ddd")
                if answer == "E"
                  answers.push("eee")
            question = {
              "kind": "multi_choice",
              "content": match_result,
              "answer": {
                "choices": [{
                  "id": "aaa",
                  "text": @RegExp_delet_letter(ele.choices[0])
                }, {
                  "id": "bbb",
                  "text": @RegExp_delet_letter(ele.choices[1])
                }, {
                  "id": "ccc",
                  "text": @RegExp_delet_letter(ele.choices[2])
                }, {
                  "id": "ddd",
                  "text": @RegExp_delet_letter(ele.choices[3])
                }, {
                  "id": "eee",
                  "text": @RegExp_delet_letter(ele.choices[4])
                }],
                "corrects": answers
              }
            }
            questions_multi.push(question)

      question_single_hash = {
         "question": questions_single
      }
      question_multi_hash = {
        "question": questions_multi
      }
      input = jQuery(".output textarea").val(JSON.stringify(question_single_hash))
      input = jQuery(".output-multi textarea").val(JSON.stringify(question_multi_hash))

    @$eml.on "click",".submit-question .save-converted-result",->
      single_choice_result = jQuery(".output textarea").val()
      multi_choice_result = jQuery(".output-multi textarea").val()
      single_to_json = JSON.parse(single_choice_result)
      multi_to_json = JSON.parse(multi_choice_result)
      console.log multi_to_json
      jQuery.ajax
        url: "/match_word/insert_into_question",
        method: "post",
        data:{single_quesiton: single_to_json, multi_question: multi_to_json}
      .success (msg)->
        console.log msg
      .error (msg)->
        console.log msg


jQuery(document).on "ready page:load", ->
  if jQuery(".question").length > 0
    new SaveQuestion jQuery(".question")