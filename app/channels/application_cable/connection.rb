# frozen_string_literal: true

# ActionCable module's Connection class to provide real-time features for Rails application
# Enabling client-server connections, for example, if single client utilizes multiple browser tabs
module ApplicationCable
  class Connection < ActionCable::Connection::Base
  end
end
