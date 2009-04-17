require 'rubygems'
require 'newgem'
require File.dirname(__FILE__) + '/lib/tokyo_model'

$hoe = Hoe.new('tokyo_model', TokyoModel::VERSION) do |p|
  p.developer('Adrian Mugnolo', 'adrian@mugnolo.com')
  p.developer('Norman Clarke', 'norman@randomba.org')
  p.changes = p.paragraphs_of("History.txt", 0..1).join("\n\n")
  p.rubyforge_name = "tokyo-model"
  p.url = "http://github.com/rubysouth/tokyo_model"
  p.extra_dev_deps = [
    ['newgem', ">= #{::Newgem::VERSION}"]
  ]
end

require 'newgem/tasks'
