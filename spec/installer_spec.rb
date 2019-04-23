require 'spec_helper'

RSpec.describe 'owl installer' do
  context 'structure: :app' do
    before do
      Dir.chdir('spec')
      Dir.chdir('test_apps')
      FileUtils.rm_rf('railing') if Dir.exist?('railing')
    end

    after do
      Dir.chdir('..') if Dir.pwd.end_with?('railing')
      FileUtils.rm_rf('railing') if Dir.exist?('railing')
      Dir.chdir('..')
      Dir.chdir('..')
    end

    it 'can install in a rails app without sprockets and webpacker gem' do
      `bundle exec rails new railing --skip-git --skip-bundle --skip-sprockets --skip-spring --skip-bootsnap`
      expect(Dir.exist?('railing')).to be true
      Dir.chdir('railing')
      arg_val = %w[rails]
      expect(Dir.exist?(File.join('railing', 'config', 'webpack'))).to be false
      OpalWebpackLoader::Installer::CLI.start(arg_val)

      expect(File.exist?(File.join('app', 'assets', 'javascripts', 'application.js'))).to be true
      expect(File.exist?(File.join('app', 'assets', 'javascripts', 'application.js_owl_new'))).to be true
      expect(File.exist?(File.join('app', 'assets', 'javascripts', 'application_common.js'))).to be true
      expect(File.exist?(File.join('app', 'assets', 'javascripts', 'application_debug.js'))).to be true
      expect(File.exist?(File.join('app', 'assets', 'javascripts', 'application_ssr.js'))).to be true
      expect(File.exist?(File.join('app', 'opal', 'opal_loader.rb'))).to be true
      expect(File.exist?(File.join('config', 'initializers', 'opal_webpack_loader.rb'))).to be true
      expect(File.exist?(File.join('config', 'webpack', 'debug.js'))).to be true
      expect(File.exist?(File.join('config', 'webpack', 'development.js'))).to be true
      expect(File.exist?(File.join('config', 'webpack', 'production.js'))).to be true
      expect(File.exist?('package.json')).to be true
      expect(File.exist?('Procfile')).to be true
    end

    it 'can install in a rails app without sprockets and webpacker gem specifying another opal files dir' do
      `bundle exec rails new railing --skip-git --skip-bundle --skip-sprockets  --skip-spring --skip-bootsnap`
      expect(Dir.exist?('railing')).to be true
      Dir.chdir('railing')
      arg_val = %w[rails -o hyperhyper]
      expect(Dir.exist?(File.join('railing', 'config', 'webpack'))).to be false
      OpalWebpackLoader::Installer::CLI.start(arg_val)

      expect(File.exist?(File.join('app', 'assets', 'javascripts', 'application.js'))).to be true
      expect(File.exist?(File.join('app', 'assets', 'javascripts', 'application.js_owl_new'))).to be true
      expect(File.exist?(File.join('app', 'assets', 'javascripts', 'application_common.js'))).to be true
      expect(File.exist?(File.join('app', 'assets', 'javascripts', 'application_debug.js'))).to be true
      expect(File.exist?(File.join('app', 'assets', 'javascripts', 'application_ssr.js'))).to be true
      expect(File.exist?(File.join('app', 'hyperhyper', 'hyperhyper_loader.rb'))).to be true
      expect(File.exist?(File.join('config', 'initializers', 'opal_webpack_loader.rb'))).to be true
      expect(File.exist?(File.join('config', 'webpack', 'debug.js'))).to be true
      expect(File.exist?(File.join('config', 'webpack', 'development.js'))).to be true
      expect(File.exist?(File.join('config', 'webpack', 'production.js'))).to be true
      expect(File.exist?('package.json')).to be true
      expect(File.exist?('Procfile')).to be true
    end

    # it 'doesnt install in a rails app when webpacker gem is used, prints warning' do
    # TODO
    # end
  end

  context 'structure: :flat' do
    before do
      Dir.chdir('spec')
      Dir.chdir('test_apps')
      FileUtils.rm_rf('flattering') if Dir.exist?('flattering')
    end

    after do
      Dir.chdir('..') if Dir.pwd.end_with?('flattering')
      FileUtils.rm_rf('flattering') if Dir.exist?('flattering')
      Dir.chdir('..')
      Dir.chdir('..')
    end

    it 'can install in a roda app' do
      FileUtils.cp_r(File.join('..', 'fixtures', 'flattering'), File.join('.'))
      expect(Dir.exist?('flattering')).to be true
      Dir.chdir('flattering')
      arg_val = %w[flat]
      OpalWebpackLoader::Installer::CLI.start(arg_val)
      expect(File.exist?(File.join('javascripts', 'application.js'))).to be true
      expect(File.exist?(File.join('javascripts', 'application_common.js'))).to be true
      expect(File.exist?(File.join('javascripts', 'application_debug.js'))).to be true
      expect(File.exist?(File.join('javascripts', 'application_ssr.js'))).to be true
      expect(File.exist?(File.join('opal', 'opal_loader.rb'))).to be true
      expect(File.exist?(File.join('owl_init.rb'))).to be true
      expect(File.exist?(File.join('webpack', 'debug.js'))).to be true
      expect(File.exist?(File.join('webpack', 'development.js'))).to be true
      expect(File.exist?(File.join('webpack', 'production.js'))).to be true
      expect(File.exist?('package.json')).to be true
      expect(File.exist?('Procfile')).to be true
    end
  end

  # TODO tests for iso, pot them in the isomorfeus-installer
end