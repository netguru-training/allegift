angular.module('allegift').controller "searchController", [
  '$scope', '$http',
  ($scope, $http) ->
    $scope.query = ''
    $scope.gifts
    $scope.AllGifts
    $scope.page = 1
    $scope.prevClass = "disabled";

    $scope.getAll = ->
      $http.get('/gifts/live_search')
      .success (data) ->
        $scope.AllGifts = data
        $scope.updatePages()
        console.log data
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.getAll()

    $scope.willPaginateCollection = {
      currentPage : 1,
      perPage : 10,
      offset : 0
    };

    $scope.range = () ->
      new Array($scope.willPaginateCollection.totalPages)

    $scope.changePage = (number) ->
      console.log number
      $scope.page = number
      $scope.updatePages()

    $scope.updatePages = ->
      $scope.willPaginateCollection.totalEntries = $scope.AllGifts.length
      $scope.willPaginateCollection.totalPages = Math.ceil($scope.AllGifts.length/$scope.willPaginateCollection.perPage)
      $scope.start = ($scope.page-1)*$scope.willPaginateCollection.perPage
      $scope.end = ($scope.page)*$scope.willPaginateCollection.perPage
      console.log $scope.start, $scope.end
      $scope.gifts = $scope.AllGifts.slice($scope.start,$scope.end );



    $scope.searchClick = ->
      console.log $scope.query
      $http.get('/gifts/live_search?search_query='+$scope.query)
      .success (data) ->
        $scope.AllGifts = data
        $scope.updatePages()
        $scope.changePage(1)
        console.log data
        return
      .error (data) ->
        console.log('Error: ' + data)
        return


    $scope.registerSanta = (id) ->
      $http.patch('/gifts/'+id+'/register_santa')
      .success (data) ->
        console.log data
        $scope.gifts = $scope.gifts.filter((el) ->
            el.id isnt data.id
        )
        return
      .error (data) ->
        console.log('Error: ' + data)
        return

    $scope.nextPage = ->
      if ($scope.page < $scope.willPaginateCollection.totalPages)
        $scope.changePage($scope.page+1)
        $scope.prevClass = ""
      else
        $scope.nextClass = "disabled"
      if ($scope.page == $scope.willPaginateCollection.totalPages)
        $scope.nextClass = "disabled"

    $scope.prevPage = ->
      if ($scope.page > 1)
        $scope.changePage($scope.page-1)
        $scope.nextClass = ""
      else
        $scope.prevClass = "disabled"
      if ($scope.page == 1)
        $scope.prevClass = "disabled"

]