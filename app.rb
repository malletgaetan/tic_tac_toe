require_relative './app/router.rb'
require_relative './app/game_controller.rb'

router = Router.new(GameController.new)
router.run
