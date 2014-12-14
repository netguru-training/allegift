angular.module('allegift').controller "searchController", [
  '$scope', '$http',
  ($scope, $http) ->
    $scope.query = ''
    $scope.gifts
    $scope.AllGifts
    $scope.page = 1
    $scope.prevClass = "disabled";
    $scope.nextClass = "";
    $scope.pageClass = [];



    $scope.getAll = ->
      $http.get('/gifts/live_search')
      .success (data) ->
        $scope.AllGifts = data
        $scope.updatePages()
        $scope.pageClass[0] = 'active'
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
      $scope.page = number
      $scope.updatePages()
      $scope.pageClass[number-1] = 'active'


    $scope.updatePages = ->
      $scope.willPaginateCollection.totalEntries = $scope.AllGifts.length
      $scope.willPaginateCollection.totalPages = Math.ceil($scope.AllGifts.length/$scope.willPaginateCollection.perPage)
      $scope.start = ($scope.page-1)*$scope.willPaginateCollection.perPage
      $scope.end = ($scope.page)*$scope.willPaginateCollection.perPage
      $scope.gifts = $scope.AllGifts.slice($scope.start,$scope.end );
      $scope.pageClass = new Array($scope.willPaginateCollection.totalPages)
      if ($scope.page < $scope.willPaginateCollection.totalPages)
        $scope.prevClass = ""
      else
        $scope.nextClass = "disabled"
      if ($scope.page > 1)
        $scope.nextClass = ""
      else
        $scope.prevClass = "disabled"
      if ($scope.page == 1)
        $scope.prevClass = "disabled"
      if ($scope.page == $scope.willPaginateCollection.totalPages)
        $scope.nextClass = "disabled"





    $scope.searchClick = ->
      $http.get('/gifts/live_search?search_query='+$scope.query)
      .success (data) ->
        $scope.AllGifts = data
        $scope.updatePages()
        $scope.changePage(1)
        return
      .error (data) ->
        console.log('Error: ' + data)
        return


    $scope.registerSanta = (id) ->
      $http.patch('/gifts/'+id+'/register_santa')
      .success (data) ->
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