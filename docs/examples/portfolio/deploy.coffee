_       = require('lodash')
Waffel  = require('../../../lib/index');
filters = require('./lib/filters')
helpers = require('./lib/helpers')
thumbs  = require('./lib/thumbs')
shell   = require('shelljs')
Promise = require('bluebird')

module.exports = (options) ->
  new Promise (resolve, reject) ->
    shell.exec 'npm run build'
    pattern           = "#{__dirname}/data/images/pictures/*"
    thumbPath         = "#{__dirname}/app/assets/images/pictures/thumbs"
    thumbRelativePath = 'images/pictures/thumbs'
    root              = __dirname
    thumbnailWidt     = 600

    thumbs pattern, thumbPath, thumbRelativePath, thumbnailWidth, root, (imgInfo) ->
      opts = _.extend options,
        root:     __dirname,
        filters:  filters,
        helpers:  helpers

      wfl = new Waffel opts

      wfl.init()
        .then ->
          wfl.generate
            data:
              imgInfo:  imgInfo
          resolve wfl
        .catch reject
