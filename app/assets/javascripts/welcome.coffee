# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
app = angular.module('app',[
  'ngMaterial',
  'ngResource',
  'cfp.hotkeys',
  'ngRoute',
  'templates'
])

app.config([
  '$routeProvider',
  '$mdThemingProvider',
  ($routeProvider, $mdThemingProvider) ->

    $routeProvider
      .when '/login',
        templateUrl: 'login.html'
        controller: 'UsersController'

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


app.controller('UsersController', [ '$scope' , '$resource', 'hotkeys' , ($scope, $resource, hotkeys)->
  User = $resource('/users/:userId', { userId : "@id", format: 'json'},
    { 'create': {method: 'POST'} }
  )

  User.query(keywords: null, (results)-> $scope.users = results)

  $scope.save = ->
    promise = User.create({user: {name: $scope.name}})
    promise.$promise.then (model) ->
      $scope.users.push(model)
    $scope.name = null



])





