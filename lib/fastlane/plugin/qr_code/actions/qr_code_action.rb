require 'fastlane/action'
require_relative '../helper/qr_code_helper'

module Fastlane
  module Actions
    class QrCodeAction < Action
      def self.run(params)
        UI.message("The qr_code plugin is working!")
      end

      def self.description
        "Generates QR codes that you may use in the rest of your workflow."
      end

      def self.authors
        ["Mathijs Bernson"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "TODO: Write a nice description of the plugin here"
      end

      def self.available_options
        [
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "QR_CODE_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
