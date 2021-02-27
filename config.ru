require './config/environment'

use Rack::MethodOverride
use UsersController
use PostsController
use DoctorsController
run ApplicationController