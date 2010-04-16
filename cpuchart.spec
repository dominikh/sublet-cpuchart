# -*- encoding: utf-8 -*-
# cpuchart specification file
# Created with sur-0.2.155
Sur::Specification.new do |s|
  s.name        = "cpuchart"
  s.authors     = [ "Dominik Honnef" ]
  s.date        = "Sun Apr 11 15:28 CEST 2010"
  s.contact     = "dominikho@gmx.net"
  s.description = "Shows cpu usage using a chart"
  s.version     = "0.1"
  s.tags        = [ "cpu", "chart" ]
  s.files       = [ "cpuchart.rb" ]
  s.icons       = [ ]
  s.add_dependency "subtle-graph", "0.0.2"
  s.subtlext_version = "0.9.1883"
end
