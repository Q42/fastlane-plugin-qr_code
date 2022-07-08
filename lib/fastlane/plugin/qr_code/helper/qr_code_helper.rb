require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class QrCodeHelper
      # class methods that you define here become available in your action
      # as `Helper::QrCodeHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the qr_code plugin helper!")
      end
    end
  end
end
