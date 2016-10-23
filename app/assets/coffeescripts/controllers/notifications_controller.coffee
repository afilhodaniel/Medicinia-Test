@window[APP_NAME].controller 'NotificationsController', ['$scope', '$http', '$pusher', ($scope, $http, $pusher) ->

  CATEGORY_SLUG = ['exam', 'appointment', 'surgery']
  CATEGORY_NAME = ['Exame', 'Consulta', 'Cirurgia']

  bootstrap = ->
    $scope.getAllNotifications()
    listenNewNotifications()

  listenNewNotifications = ->
    client = new Pusher(PUSHER_KEY)

    pusher = $pusher(client)

    channel = pusher.subscribe('notification_channel');

    channel.bind 'new_notification', (data) ->
      $scope.notifications.unshift data

  $scope.getAllNotifications = ->
    $http
      url: '/api/v1/notifications.json?user_id=:user_id'.replace(':user_id', USER_ID)
      method: 'get'
    .success (data) ->
      $scope.notifications = data.notifications

  $scope.getNotificationsByCategory = (category) ->
    $http
      url: '/api/v1/notifications.json?user_id=:user_id&category=:category'.replace(':user_id', USER_ID).replace(':category', category)
      method: 'get'
    .success (data) ->
      $scope.notifications = data.notifications

  $scope.getNotificationsBySearch = (event) ->
    event.preventDefault()

    note = angular.element(event.target).find('input[name="notification[note]"]')[0].value

    $http
      url: '/api/v1/notifications/search.json?user_id=:user_id&note=:note'.replace(':user_id', USER_ID).replace(':note', note)
      method: 'get'
    .success (data) ->
      if data.notifications.length > 0
        angular.element('.filter-radio')[0].checked = true
        $scope.notifications = data.notifications
      else
        $scope.notifications = []

  $scope.getNotificationCategorySlug = (category) ->
    CATEGORY_SLUG[category]

  $scope.getNotificationCategoryName = (category) ->
    CATEGORY_NAME[category]

  $scope.createNotification = (event) ->
    event.preventDefault()

    if angular.element(event.target).find('input[name="notification[category]"]:checked').length == 0
      category = ''
    else
      category = angular.element(event.target).find('input[name="notification[category]"]:checked')[0].value

    data = {
      authenticity_token: angular.element(event.target).find('input[name=authenticity_token]')[0].value,
      notification: {
        category: category,
        note: angular.element(event.target).find('textarea[name="notification[note]"]')[0].value,
        user_id: angular.element(event.target).find('input[name="notification[user_id]"]')[0].value
      }
    }

    $http
      url: '/api/v1/notifications.json?user_id=:user_id'.replace(':user_id', USER_ID)
      method: 'post'
      data: data
    .success (data) ->
      if data.success
        $scope.errors = {}
        clearForm(event)
        $('html, body').animate({
          scrollTop: 0
        })
      else
        $scope.errors = data.errors

  clearForm = (event) ->
    angular.element(event.target).find('input[name="notification[category]"]:checked')[0].checked = false
    angular.element(event.target).find('textarea[name="notification[note]"]')[0].value = ''

  $scope.deleteNotification = (event, notification) ->
    event.preventDefault()

    $http
      url: '/api/v1/notifications/:id.json?user_id=:user_id'.replace(':id', notification.id).replace(':user_id', USER_ID)
      method: 'delete'
    .success (data) ->
      if data.success
        $scope.notifications.splice($scope.notifications.indexOf(notification), 1)

  $scope.confirmNotification = (event, notification) ->
    event.preventDefault()

    data = {
      notification: {
        confirmed: !notification.confirmed
      }
    }

    $http
      url: '/api/v1/notifications/:id.json?user_id=:user_id'.replace(':id', notification.id).replace(':user_id', USER_ID)
      method: 'put'
      data: data
    .success (data) ->
      if data.success
        $scope.notifications[$scope.notifications.indexOf(notification)] = data.notification

  bootstrap()

]