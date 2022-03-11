require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

Splunk::Otel.configure do |configurator|
  $configurator = configurator

  class << configurator
    def test_shutdown
      @span_processors.each { |sp| sp.shutdown }
    end
  end
end

tracer = OpenTelemetry.tracer_provider.tracer('test', '1.0')
tracer.in_span('test-span') do
  puts "test-span execution"
end

$configurator.test_shutdown
