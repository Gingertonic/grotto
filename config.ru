require './config/environment'
require './config/inflections'


use Rack::MethodOverride
use SessionController
use UsersController
use DivesController
use DivesitesController
run ApplicationController
