# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


app = angular.module('app',[
  'ngMaterial',
  'ngResource',
  'cfp.hotkeys',
  'ngRoute',
  'ngMessages',
  'templates',
  'ng-token-auth',
  'isiUser',
  'pusher-angular'
])

app.config([
  '$routeProvider',
  '$mdThemingProvider',
  '$authProvider',
  ($routeProvider, $mdThemingProvider, $authProvider) ->

    authenticateRoute = ($auth, $location)  ->
      return $auth.validateUser().catch (res)->
        $location.path('/login')
  
    $routeProvider
      .when '/login',
        templateUrl: 'login.html'
        controller: 'LoginController'

      .when '/signup',
        templateUrl: 'signup.html'
        controller: 'SignupController'
        
      .when '/chat',
        templateUrl: 'chat.html'
        controller: 'ChatController'
        resolve: 
          auth: authenticateRoute
        

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

  
    $authProvider.configure({
      apiUrl: '',
      storage: 'localStorage'      
  })
]);



app.controller('ChatController', [ '$scope' , '$resource', '$auth', '$location', 'UserProvider', '$pusher', 'hotkeys', '$anchorScroll', '$timeout', ($scope, $resource, $auth, $location, UserProvider, $pusher, hotkeys, $anchorScroll, $timeout)->
  
  client = new Pusher('4ce30a88ba48b2442267', {
      cluster: 'eu',
      encrypted: true
  })
  pusher = $pusher(client)
  Message = $resource('/messages/:messageID', {messageID: '@id'}, {
    getAll: {
      url: '/messages',
      method: 'GET',
      isArray: true
    }  
  })
  
  $scope.openMenu = ($mdMenu, ev) -> 
    originatorEv = ev;
    $mdMenu.open(ev);
  
  $scope.goBottom= () ->
    $timeout( () ->
        $location.hash("last")
        $anchorScroll()
    , 0)

  
  $scope.send = ->
    message = {body: $scope.message}
    message.user = UserProvider.getUser()
    $scope.messages.push(message)

    Message.save(message)
    $scope.message = ''
    $auth.validateUser()
      
  $scope.messages = []
  Message.getAll (data) ->
    $scope.messages = data
  
  pusher.subscribe('general-channel')
  pusher.bind 'new-message', (data) ->
    if data.user.uid != UserProvider.getUser().uid
      $scope.messages.push(data)
    
             
  
  $scope.curUser = UserProvider.getUser()
  
  $scope.logout = ->
    $auth.signOut()
    .then (resp) ->
       $location.path('/login')
       

  document.getElementsByTagName("body")[0].classList.add("blue-background");
])


app.controller('LoginController', [ '$scope' , '$resource', '$auth', '$location', ($scope, $resource, $auth, $location)->
    
  $scope.submitLogin = (loginForm) ->
    $auth.submitLogin(loginForm)
    .then (resp) -> 
      $location.path('/chat')
    .catch (resp) ->
        $scope.error_bool = true
        if (typeof resp is 'object')
          $scope.error = resp
        else
          $scope.error = {errors: {full_messages: ["Server fatal error"]}}

  document.getElementsByTagName("body")[0].classList.add("blue-background");
])

app.controller('SignupController', [ '$scope' , '$resource', '$mdDialog', '$auth', '$location', '$mdToast', ($scope, $resource, $mdDialog, $auth, $location, $mdToast) ->

  $scope.status = '  '
  $scope.customFullscreen = false
  $scope.user_info={}

  $scope.save = (registrationForm) ->
    $auth.submitRegistration(registrationForm)
    .then (resp) ->
      $scope.user_info= {email: registrationForm.email, password: registrationForm.password}
      $auth.submitLogin($scope.user_info)
      .then (resp) ->
        $location.path('/chat')
        $mdToast.show(
          $mdToast.simple().textContent('You\'ve been successfully registered and logged in.')
        )
      .catch (resp) ->
        $scope.error_bool = true
        if (typeof resp is 'object')
          $scope.error = resp.data
        else
          $scope.error = {errors: {full_messages: ["Server fatal error"]}}
    .catch (resp) ->
        $scope.error_bool = true
        if (typeof resp is 'object')
          $scope.error = resp.data
        else
          $scope.error = {errors: {full_messages: ["Server fatal error"]}}

  $scope.showAlert = (ev)->
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

app.run ['$auth', '$rootScope', 'UserProvider', ($auth, $rootScope, UserProvider) ->
  $rootScope.$on 'auth:login-success', (ev, user) -> 
     UserProvider.login(user)              
  
  $rootScope.$on 'auth:logout-success', (ev) ->
    UserProvider.logout
    
  $rootScope.$on 'auth:validation-success', (ev, user) -> 
    UserProvider.login(user)              
    
  $rootScope.$watch 'assets', (value) ->
    if value 
       $rootScope.assets = JSON.parse(String(value).replace(/&quote;/ig,'"'))
]


