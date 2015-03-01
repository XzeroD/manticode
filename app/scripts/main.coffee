exoskeleton = require '../components/exoskeleton/exoskeleton.js'
class MainView extends exoskeleton.View
  render: ->
    @$el.html @template @model.attributes
  template: require '../templates/test.html'
  initialize: ->
    @listenTo @model, 'change', @render
    @render()

class MainModel extends exoskeleton.Model
  defaults:
    test: 'fus ro dah'

model = new MainModel
view  = new MainView model: model, el: document.getElementById 'main'
