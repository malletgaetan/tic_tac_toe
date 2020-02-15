require_relative 'app/router.rb'
require_relative 'app/controller.rb'


router = Router.new(Controller.new)
router.run
