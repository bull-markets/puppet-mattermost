require 'spec_helper_acceptance'

describe 'unsupported distributions and OSes', if: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  it 'should fail' do
    pp = <<-EOS
    class { 'mattermost': }
    EOS
    expect(apply_manifest(pp, expect_failures: true).stderr).to match(%r{is not supported on an}i)
  end
end
