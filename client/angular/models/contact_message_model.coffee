BaseModel    = require 'shared/models/base_model'
AppConfig = require 'shared/services/app_config.coffee'

angular.module('loomioApp').factory 'ContactMessageModel', ->
  class ContactMessageModel extends BaseModel
    @singular: 'contactMessage'
    @plural: 'contactMessages'
    @serializableAttributes: AppConfig.permittedParams.contact_message
