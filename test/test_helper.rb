$VERBOSE = false
require 'fileutils'
require 'test/unit'
require 'contest'

require File.dirname(__FILE__) + '/../lib/tokyo_model'

def tmpdir
  @tmpdir ||= File.join(File.dirname(File.expand_path(__FILE__)), "tmp")
end

def dbpath
  "#{tmpdir}/test.tdb"
end

FileUtils.mkdir_p tmpdir