# Fastlane qr_code plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-qr_code)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-qr_code`, add it to your project by running:

```bash
fastlane add_plugin qr_code
```

## About qr_code

This plugin generates QR codes that you may use in the rest of your workflow.

You can use a PNG image of the QR code, or an ANSI text representation that you can print to a console.

## Example

Example usage of this plugin:

```ruby
lane :test do
  code = qr_code(contents: 'https://q42.com/')
  
  # Print a ANSI text-representation of the QR code to the console
  puts code['QR_CODE_TEXT']

  # Store the QR code somewhere a PNG file to use it later on
  FileUtils.cp(code['QR_CODE_PNG_PATH'], './qr_code.png')

  # Upload QR code to S3...
  aws_s3(
    access_key: ENV["S3_ACCESS_KEY"],
    secret_access_key: ENV["S3_SECRET_ACCESS_KEY"],
    bucket: ENV["S3_BUCKET"],
    region: ENV["S3_REGION"],
    files: [
      code['QR_CODE_PNG_PATH']
    ],
    upload_metadata: false
  )
  qr_code_image_url = lane_context[SharedValues::S3_FILES_OUTPUT_PATHS][0]

  # ...and post it to Slack!
  slack(
    message: "Build succeeded! Scan the code to install it on your device.",
    slack_url: ENV["SLACK_WEB_HOOK_URL"],
    attachment_properties: {
      image_url: qr_code_image_url,
    }
  )
end
```

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
