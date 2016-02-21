cb = (start, end) ->  
  $("#reportrange span").html start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY')

changeReportRange = (start, end) ->
  $("#_from").val(start.format('YYYY-MM-DD'))
  $("#_to").val(end.format('YYYY-MM-DD'))
  $("#_from").parent('form').submit()

ready = ->
  cb(moment($("#_from").val()), moment($("#_to").val()))
  
  $('#reportrange').daterangepicker(
    {
      ranges: {
         'This Month': [moment().startOf('month'), moment().endOf('month')],
         'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],      
         '4 Month Arrears': [moment().subtract(4, 'month').startOf('month'), moment().subtract(4, 'month').endOf('month')]
      }
    },
    changeReportRange
  )

  $('[data-remote]').each (index) ->
      elem = $(this)
      elem.selectize
        valueField: elem.data('value')
        labelField: elem.data('label')
        searchField: elem.data('fields')
        create: false
        render:
          option: (item, escape) ->
            '<div>' + item.name + '</div>'
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


$(document).ready ready
$(document).on 'page:load', ready