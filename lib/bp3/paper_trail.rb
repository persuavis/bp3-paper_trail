# frozen_string_literal: true

require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/inflector'

require_relative 'paper_trail/railtie'
require_relative 'paper_trail/version'

module Bp3
  module PaperTrail
    mattr_accessor :version_class_name

    def self.version_class
      @@version_class ||= version_class_name.constantize # rubocop:disable Style/ClassVars
    end
  end
end
