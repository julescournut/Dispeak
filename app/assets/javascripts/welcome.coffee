# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
app = angular.module('app',[
  'ngMaterial',
  'ngResource',
  'cfp.hotkeys',
  'ngRoute',
  'ngMessages',
  'templates'
])

app.config([
  '$routeProvider',
  '$mdThemingProvider',
  ($routeProvider, $mdThemingProvider) ->

    $routeProvider
      .when '/login',
        templateUrl: 'login.html'
        controller: 'LoginController'

      .when '/signup',
        templateUrl: 'signup.html'
        controller: 'SignupController'

    pastBlueMap = $mdThemingProvider.extendPalette 'blue', {
      '500': '#5F767F',
      'contrastDefaultColor': 'dark'
    }

    $mdThemingProvider
      .definePalette 'pastBlue', pastBlueMap

    $mdThemingProvider
      .theme 'default'
      .primaryPalette 'pastBlue',
        'default': '500'

]);


app.controller('LoginController', [ '$scope' , '$resource', ($scope, $resource)->
  User = $resource('/users/:userId', { userId : "@id", format: 'json'},
    { 'create': {method: 'POST'} }
  )
    

#  User.query(keywords: null, (results)-> $scope.users = results)

#  $scope.save = ->
#    promise = User.create({user: {name: $scope.name}})
#    promise.$promise.then (model) ->
#      $scope.users.push(model)
#    $scope.name = null

  document.getElementsByTagName("body")[0].classList.add("blue-background");
])

app.controller('SignupController', [ '$scope' , '$resource', '$mdDialog', ($scope, $resource, $mdDialog)->
  User = $resource('/users/:userId', { userId : "@id", format: 'json'},
    { 'create': {method: 'POST'} }
  )

  $scope.status = '  '
  $scope.customFullscreen = false

  User.query(keywords: null, (results)-> $scope.users = results)

  $scope.save = ->
    promise = User.create({user: {name: $scope.name, email: $scope.email, password: $scope.password}})
    promise.$promise.then (model) ->
      $scope.users.push(model)

  $scope.showAlert = (ev)->
# Appending dialog to document.body to cover sidenav in docs app
# Modal dialogs should fully cover application
# to prevent interaction outside of dialog
    if ($scope.projectForm.$valid)
      $mdDialog.show (
        $mdDialog.alert()
          .parent(angular.element(document.querySelector('#popupContainer')))
          .clickOutsideToClose(false)
          .title('Success !')
          .textContent('You have successfully registered and logged in.')
          .ariaLabel('Alert Dialog Demo')
          .ok('Cool!')
          .targetEvent(ev)
  )

  document.getElementsByTagName("body")[0].classList.add("blue-background");
])




