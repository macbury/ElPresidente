require 'elpresidente/version'
require "active_support/all"
require 'async/container'
require 'async/container/notify'
require 'async/semaphore'
require 'async/clock'
require 'async/barrier'
require 'async/http/internet'
require 'slack-ruby-client'
require 'async/redis'
require 'google_drive'
require 'nokogiri'
require 'addressable'
require 'fugit'

require_relative './elpresidente/loader'

module Elpresidente
  module Skills;end
  module Blackboard;end
  class Error < StandardError; end

  def self.loader
    @loader ||= Loader.new
  end
end
