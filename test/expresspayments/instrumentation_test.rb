# frozen_string_literal: true

require_relative "../test_helper"

module ExpressPayments
  class InstrumentationTest < Test::Unit::TestCase
    context ".notify" do
      teardown do
        ExpressPayments::Instrumentation.send(:subscribers).clear
      end

      should "notify subscribers for the right topic" do
        sub1_events = []
        ExpressPayments::Instrumentation.subscribe(:test1, :sub1) { |event| sub1_events << event }
        sub2_events = []
        ExpressPayments::Instrumentation.subscribe(:test2, :sub2) { |event| sub2_events << event }

        ExpressPayments::Instrumentation.notify(:test1, "hello")
        assert_equal(1, sub1_events.size)
        assert_equal(0, sub2_events.size)
      end

      should "notify multiple subscribers of the same topic" do
        sub1_events = []
        ExpressPayments::Instrumentation.subscribe(:test, :sub1) { |event| sub1_events << event }
        sub2_events = []
        ExpressPayments::Instrumentation.subscribe(:test, :sub2) { |event| sub2_events << event }

        ExpressPayments::Instrumentation.notify(:test, "hello")
        assert_equal(1, sub1_events.size)
        assert_equal(1, sub2_events.size)
      end

      should "not notify a subscriber once it has unsubscribed" do
        events = []
        ExpressPayments::Instrumentation.subscribe(:test, :sub) { |event| events << event }

        ExpressPayments::Instrumentation.notify(:test, "hello")
        assert_equal(1, events.size)

        ExpressPayments::Instrumentation.unsubscribe(:test, :sub)
        ExpressPayments::Instrumentation.notify(:test, "hello")
        assert_equal(1, events.size)
      end
    end

    context "RequestEventBegin" do
      should "return a frozen object" do
        event = ExpressPayments::Instrumentation::RequestBeginEvent.new(
          method: :get,
          path: "/v1/test",
          user_data: nil
        )

        assert(event.frozen?)
      end
    end

    context "RequestEventEnd" do
      should "return a frozen object" do
        mock_context = stub(
          duration: 0.1,
          method: :get,
          path: "/v1/test",
          request_id: "req_123",
          body: ""
        )

        request_context = ExpressPayments::Instrumentation::RequestContext.new(
          duration: 0.1,
          context: mock_context,
          header: nil
        )

        response_context = ExpressPayments::Instrumentation::ResponseContext.new(
          http_status: 200,
          response: nil
        )

        event = ExpressPayments::Instrumentation::RequestEndEvent.new(
          num_retries: 0,
          request_context: request_context,
          response_context: response_context,
          user_data: nil
        )

        assert(event.frozen?)
      end
    end
  end
end
