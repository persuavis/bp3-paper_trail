# frozen_string_literal: true

require 'rails/railtie'

module Bp3
  module PaperTrail
    class Railtie < Rails::Railtie
      initializer 'bp3.paper_trail.railtie.register' do |app|
        app.config.after_initialize do
          ::PaperTrail::ModelConfig # preload
          ::PaperTrail::Version # preload
          module ::PaperTrail
            # reopen ModelConfig to override version_class
            class ModelConfig
              def version_class
                ::Version # TODO: make this configurable
              end
            end

            class Version
              include Bp3::Core::Ransackable
            end
          end
        end
      end
    end
  end
end
