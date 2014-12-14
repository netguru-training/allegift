$ ->
  angular.module('allegift').controller("SearchController", [ '$scope'
    ($scope) ->

      console.log 'asd'

      $scope.searchClick = ->
        console.log query
        $http.get('/gifts/live_search?=search_query='+query)
          .success (data) ->
            console.log data
            return
          .error (data) ->
            console.log('Error: ' + data)
            return

  ])