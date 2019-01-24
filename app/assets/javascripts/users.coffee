$ ->
  $(document).on 'turbolinks:load', ->
    $('.pages').infiniteScroll
      path: "nav.pagination a[rel=next]"
      append: ".page"
      history: false
      prefill: true
      status: '.page-load-status'
