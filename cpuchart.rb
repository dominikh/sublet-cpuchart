require "subtle/dominikh/graph"

class CPU
  attr_reader :number

  def initialize(number)
    @number  = number
    @last    = 0
    @delta   = 0
    @sum     = 0
  end

  # @return [Fixnum] The current CPU load, as a percentage
  def load
    load = 0
    File.read("/proc/stat").scan(/cpu(\d+) (\d+) (\d+) (\d+)/) do |num, user, nice, system|
      next unless num.to_i == @number
      @delta      = Time.now.to_i - @last
      @delta      = 1 if(0 == @delta)
      @last       = Time.now.to_i
      sum         = user.to_i + nice.to_i + system.to_i
      use         = ((sum - @sum) / @delta / 100.0)
      @sum        = sum
      load = (use * 100.0).ceil % 100
    end

    load
  end

  # @return [Array<CPU>] An array of all {CPU CPUs}
  def self.all
    cpus = []
    File.read("/proc/stat").scan(/cpu(\d+)/) do |number|
      cpus << CPU.new(number.first.to_i)
    end
    cpus
  end
end


configure :cpuchart do |s|
  s.interval = 1
  s.graph = Dominikh::Chart.new(25, s.geometry.height)
  s.graph.extend(Dominikh::ColoredGraph)
  s.cpus = CPU.all
end

on :run do |s|
  val = s.cpus.map(&:load).inject(:+) / s.cpus.size.to_f
  s.graph.push(val)
  s.data = s.graph.to_s
end
