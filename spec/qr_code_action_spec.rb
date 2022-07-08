describe Fastlane::Actions::QrCodeAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The qr_code plugin is working!")

      Fastlane::Actions::QrCodeAction.run(nil)
    end
  end
end
