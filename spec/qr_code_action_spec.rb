require 'pathname'

describe Fastlane::Actions::QrCodeAction do
  describe 'QR code generator' do
    it "raises an error if no contents were given" do
      expect do
        Fastlane::FastFile.new.parse("lane :test do
          qr_code
        end").runner.execute(:test)
      end.to raise_error
    end

    it "encodes a QR code as PNG file in a temporary directory" do
      test_val = 'http://example.com/123'

      result = Fastlane::FastFile.new.parse("lane :test do
          qr_code(contents: '#{test_val}')
        end").runner.execute(:test)

      expect(result).to_not be_empty

      expect(Pathname.new(result['QR_CODE_PNG_PATH'])).to exist
      expect(Pathname.new(result['QR_CODE_PNG_PATH'])).to be_file

      expect(Pathname.new(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::QR_CODE_PNG_PATH])).to exist
      expect(Pathname.new(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::QR_CODE_PNG_PATH])).to be_file
    end
  end
end
