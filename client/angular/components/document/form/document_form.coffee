Records = require 'shared/services/records.coffee'

{ applySequence } = require 'angular/helpers/apply.coffee'

angular.module('loomioApp').directive 'documentForm', ['$timeout', ($timeout) ->
  templateUrl: 'generated/components/document/form/document_form.html'
  controller: ['$scope', ($scope) ->
    $scope.$on 'initializeDocument', (_, doc, $mdMenu) ->
      $timeout -> $mdMenu.open() if $mdMenu
      $scope.document = doc.clone()

      applySequence $scope,
        steps: ['method', 'url', 'title']
        skipClose: $mdMenu? # don't emit $close if we are in an md-menu
        initialStep: if $scope.document.isNew() then 'method' else 'title'
        methodComplete: (_, method) -> $scope.document.method = method
        urlComplete:    (_, doc)    ->
          $scope.document.id    = doc.id
          $scope.document.url   = doc.url
          $scope.document.title = doc.title
        titleComplete:  (event, doc)    ->
          return unless $mdMenu
          event.stopPropagation()
          $mdMenu.close()
          $scope.$emit 'documentAdded', doc
   ]
 ]
