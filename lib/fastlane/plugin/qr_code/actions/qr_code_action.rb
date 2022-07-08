require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/qr_code_helper'
require 'rqrcode'
require 'tempfile'

module Fastlane
  module Actions
    module SharedValues
      QR_CODE_PNG_PATH = 'QR_CODE_PNG_PATH'
      QR_CODE_TEXT = 'QR_CODE_TEXT'
    end

    class QrCodeAction < Action
      def self.run(params)
        qr_code_contents = params[:contents].to_s
        UI.user_error!("No QR code contents given, pass using `contents: 'http://example.com/123'`") unless qr_code_contents.length > 0

        qr_code = RQRCode::QRCode.new(qr_code_contents)
        qr_code_text = qr_code.as_ansi
        qr_code_png = qr_code.as_png

        temp_file = Tempfile.new('qrcode')
        temp_file.write(qr_code_png.to_s)
        qr_code_png_path = temp_file.path
        temp_file.close
        IO.binwrite(qr_code_png_path, qr_code_png.to_s)

        # Setting action and environment variables
        Actions.lane_context[SharedValues::QR_CODE_PNG_PATH] = qr_code_png_path
        ENV[SharedValues::QR_CODE_PNG_PATH.to_s] = qr_code_png_path

        Actions.lane_context[SharedValues::QR_CODE_TEXT] = qr_code_text
        ENV[SharedValues::QR_CODE_TEXT.to_s] = qr_code_text

        UI.success("Successfully created QR code at path '#{Actions.lane_context[SharedValues::QR_CODE_PNG_PATH]}'")

        {
          'QR_CODE_TEXT' => qr_code_text,
          'QR_CODE_PNG_PATH' => qr_code_png_path
        }
      end

      def self.description
        "Generates QR codes that you may use in the rest of your workflow."
      end

      def self.authors
        ["Mathijs Bernson"]
      end

      def self.return_value
        "Returns the path to the QR code PNG file."
      end

      def self.details
        "The QR code PNG image is written to the system's temporary directory."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :contents,
                                  env_name: "QR_CODE_CONTENTS",
                               description: "The contents of the QR code",
                                  optional: false,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
