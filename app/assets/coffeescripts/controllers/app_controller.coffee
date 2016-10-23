@window[APP_NAME].controller 'AppController', ['$scope', ($scope) ->

  $scope.getDate = (date) ->
    date = new Date(date)

    ":date/:month/:year - :hours::minutes"
      .replace(':date', date.getDate())
      .replace(':month', date.getMonth() + 1)
      .replace(':year', date.getFullYear())
      .replace(':hours', date.getHours())
      .replace(':minutes', date.getMinutes())
]