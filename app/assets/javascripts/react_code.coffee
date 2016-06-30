@CommentBox = React.createClass
  getInitialState: ->
    comments: @props.data.comments
    current_comments_index: null

  render: ->
    <div className = "text-slide">
      <CommentList data = {@state.comments} />
    </div>


  CommentList = React.createClass
    render: ->
      <div className = "comment-list">
        {
          for item in @props.data
            display: (item)->
              =>
              <div className = "content" >{item.content}</div>
              <div className = "creator" >{item.creator}</div>
        }
      </div>


