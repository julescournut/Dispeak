
isiUser = angular.module 'isiUser', []

isiUser.factory 'UserProvider', ->
  
  _user = null
  
  getUser: ->
    return _user

  login: (user) ->
    _user = user
    
  logout: ->
    _user = null
