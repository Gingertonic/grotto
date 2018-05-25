require './config/environment'
require './config/inflections'


use Rack::MethodOverride
use SessionController
use UsersController
use DivesitesController
use DivesController
run ApplicationController
