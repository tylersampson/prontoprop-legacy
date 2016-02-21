initSelectize = ->
  $('[data-remote]').each (index) ->
      elem = $(this)
      elem.selectize
        valueField: elem.data('value')
        labelField: elem.data('label')
        searchField: elem.data('fields')
        create: false
        render:
          option: (item, escape) ->                      
            '<div>' + item[elem.data('label')] + '</div>'
        load: (query, callback) ->
          if (!query.length)
            return callback()
          $.ajax
            url: elem.data('remote') + '?q[' + elem.data('search') + ']=' + query
            type: 'GET'
            dataType: 'json'
            error: () ->
              callback()
            success: (res) ->
              console.log(res)
              callback(res)

ready = ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.row').hide()
    event.preventDefault()
    
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    initSelectize()
    event.preventDefault()
    
$(document).ready ready
$(document).on 'page:load', ready