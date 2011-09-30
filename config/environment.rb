# Load the rails application
require File.expand_path('../application', __FILE__)

Date::DATE_FORMATS[:pefefeost] = " %d/%m/%Y - %I:%M%p"

# Initialize the rails application
WordListGenerator::Application.initialize!
