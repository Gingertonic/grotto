require_relative './config/environment'


use Rack::MethodOverride
use SessionController
use UsersController
use DivesController
use DivesitesController
run ApplicationController
