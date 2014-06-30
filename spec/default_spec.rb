require 'spec_helper'

describe 'example_cookbook::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['lighttpd']['config_file'] = '/tmp/lighttpd.conf'
      node.set['lighttpd']['document_root'] = '/tmp/www'
      node.set['lighttpd']['port'] = 1111
      node.set['lighttpd']['message'] = 'I am a message'
    end.converge(described_recipe)
  end

  it 'should install lighttpd package' do
    expect(chef_run).to install_package('lighttpd')
  end

  it 'should configure lighttpd' do
    expect(chef_run).to create_template('/tmp/lighttpd.conf')
      .with_mode(0644)
      .with_owner('root')
      .with_group('root')
    expect(chef_run).to render_file('/tmp/lighttpd.conf')
      .with_content(
        <<-EOT.gsub(/^\s+/, '')
        server.document-root = "/tmp/www"
        server.port = 1111
        index-file.names = ( "index.html" )
        mimetype.assign = ( ".html" => "text/html" )
        EOT
      )
    resource = chef_run.template('/tmp/lighttpd.conf')
    expect(resource).to notify('service[lighttpd]').to(:reload).delayed
  end

  it 'should create document root directory' do
    expect(chef_run).to create_directory('/tmp/www')
      .with_mode(0755)
      .with_owner('root')
      .with_group('root')
      .with_recursive(true)
  end

  it 'should create index.html' do
    expect(chef_run).to create_template('/tmp/www/index.html')
      .with_mode(0644)
      .with_owner('root')
      .with_group('root')
    expect(chef_run).to render_file('/tmp/www/index.html')
      .with_content(/I am a message/)
  end

  it 'should enable and start lighttpd service' do
    expect(chef_run).to enable_service('lighttpd')
    expect(chef_run).to start_service('lighttpd')
  end
end
