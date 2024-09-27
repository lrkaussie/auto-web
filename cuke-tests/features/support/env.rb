require 'page-object/page_factory'
require 'rspec'
require 'page-object'
require 'rspec/expectations'
require 'require_all'
require 'yaml'
require 'fig_newton'
require 'data_magic'
require 'rubygems'
require_rel 'pages'
require 'builder'


DataMagic.yml_directory = File.join(File.dirname(__FILE__),'../../','config/data')
FigNewton.yml_directory = File.join(File.dirname(__FILE__),'../../','config/environments')
World(PageObject::PageFactory)


begin
  if ENV['HEADLESS']
    require 'headless'
    headless = Headless.new
    headless.start
    at_exit do
      headless.destroy
    end
  end
end