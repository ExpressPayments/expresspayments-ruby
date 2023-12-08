# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class QuoteTest < Test::Unit::TestCase
    should "be creatable" do
      coupon = ExpressPayments::Quote.create

      assert_requested :post, "#{ExpressPayments.api_base}/v1/quotes"
      assert coupon.is_a?(ExpressPayments::Quote)
    end

    should "be listable" do
      order_returns = ExpressPayments::Quote.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/quotes"
      assert order_returns.data.is_a?(Array)
      assert order_returns.data[0].is_a?(ExpressPayments::Quote)
    end

    should "be saveable" do
      quote = ExpressPayments::Quote.retrieve("qt_123")
      quote.description = "Sample quote description"
      quote.save
      assert_requested :post,
                       "#{ExpressPayments.api_base}/v1/quotes/#{quote.id}"
    end

    context "#accept" do
      should "accept quote" do
        quote = ExpressPayments::Quote.retrieve("qt_123")
        quote = quote.accept
        assert_requested :post,
                         "#{ExpressPayments.api_base}/v1/quotes/#{quote.id}/accept"
        assert quote.is_a?(ExpressPayments::Quote)
      end
    end

    context ".accept" do
      should "accept quote" do
        quote = ExpressPayments::Quote.accept("qt_123")
        assert_requested :post, "#{ExpressPayments.api_base}/v1/quotes/qt_123/accept"
        assert quote.is_a?(ExpressPayments::Quote)
      end
    end

    context "#cancel" do
      should "cancel quote" do
        quote = ExpressPayments::Quote.retrieve("qt_123")
        quote = quote.cancel
        assert_requested :post,
                         "#{ExpressPayments.api_base}/v1/quotes/#{quote.id}/cancel"
        assert quote.is_a?(ExpressPayments::Quote)
      end
    end

    context ".cancel" do
      should "cancel quote" do
        quote = ExpressPayments::Quote.cancel("qt_123")
        assert_requested :post, "#{ExpressPayments.api_base}/v1/quotes/qt_123/cancel"
        assert quote.is_a?(ExpressPayments::Quote)
      end
    end

    context "#finalize" do
      should "finalize quote" do
        quote = ExpressPayments::Quote.retrieve("qt_123")
        quote = quote.finalize_quote
        assert_requested :post,
                         "#{ExpressPayments.api_base}/v1/quotes/#{quote.id}/finalize"
        assert quote.is_a?(ExpressPayments::Quote)
      end
    end

    context ".finalize" do
      should "finalize quote" do
        quote = ExpressPayments::Quote.finalize_quote("qt_123")
        assert_requested :post, "#{ExpressPayments.api_base}/v1/quotes/qt_123/finalize"
        assert quote.is_a?(ExpressPayments::Quote)
      end
    end

    context "#line_items" do
      should "list item items for quote" do
        quote = ExpressPayments::Quote.retrieve("qt_123")
        line_items = quote.list_line_items
        assert_requested :get,
                         "#{ExpressPayments.api_base}/v1/quotes/#{quote.id}/line_items"

        assert line_items.data.is_a?(Array)
        assert line_items.data[0].is_a?(ExpressPayments::LineItem)
      end
    end

    context ".line_items" do
      should "list item items for quote" do
        line_items = ExpressPayments::Quote.list_line_items("qt_123")
        assert_requested :get,
                         "#{ExpressPayments.api_base}/v1/quotes/qt_123/line_items"

        assert line_items.data.is_a?(Array)
        assert line_items.data[0].is_a?(ExpressPayments::LineItem)
      end
    end

    context "#computed_upfront_line_items" do
      should "list item items for quote" do
        quote = ExpressPayments::Quote.retrieve("qt_123")
        line_items = quote.list_computed_upfront_line_items
        assert_requested :get,
                         "#{ExpressPayments.api_base}/v1/quotes/#{quote.id}/computed_upfront_line_items"

        assert line_items.data.is_a?(Array)
        assert line_items.data[0].is_a?(ExpressPayments::LineItem)
      end
    end

    context ".computed_upfront_line_items" do
      should "list item items for quote" do
        line_items = ExpressPayments::Quote.list_computed_upfront_line_items("qt_123")
        assert_requested :get,
                         "#{ExpressPayments.api_base}/v1/quotes/qt_123/computed_upfront_line_items"

        assert line_items.data.is_a?(Array)
        assert line_items.data[0].is_a?(ExpressPayments::LineItem)
      end
    end

    context "uploads_base methods" do
      setup do
        # We don't point to the same host for the API and uploads in
        # production, but `expresspayments-mock` supports both APIs.
        ExpressPayments.uploads_base = ExpressPayments.api_base
      end

      context "#pdf" do
        should "generate binary response for quote" do
          quote = ExpressPayments::Quote.retrieve("qt_123")
          body = +""

          # Set `api_base` to `nil` to ensure that these PDF requests are _not_ sent
          # to the default API hostname.
          ExpressPayments.api_base = nil

          quote.pdf do |read_body_chunk|
            body << read_body_chunk
          end

          # Reset the API base.
          ExpressPayments.api_base = ExpressPayments.uploads_base

          assert_requested :get,
                           "#{ExpressPayments.uploads_base}/v1/quotes/#{quote.id}/pdf"
          assert_equal "ExpressPayments binary response", body
        end

        should "raise when no block is passed" do
          quote = ExpressPayments::Quote.retrieve("qt_123")

          assert_raises ArgumentError do
            quote.pdf
          end
        end
      end

      context ".pdf" do
        should "generate binary response for quote" do
          body = +""

          # Set `api_base` to `nil` to ensure that these PDF requests are _not_ sent
          # to the default API hostname.
          ExpressPayments.api_base = nil

          ExpressPayments::Quote.pdf("qt_123") do |read_body_chunk|
            body << read_body_chunk
          end

          # Reset the API base.
          ExpressPayments.api_base = ExpressPayments.uploads_base

          assert_requested :get,
                           "#{ExpressPayments.uploads_base}/v1/quotes/qt_123/pdf"
          assert_equal "ExpressPayments binary response", body
        end

        should "raise when no block is passed" do
          assert_raises ArgumentError do
            ExpressPayments::Quote.pdf("qt_123")
          end
        end

        should "raise when no ID is passed" do
          assert_raises ArgumentError do
            ExpressPayments::Quote.pdf do |read_body_chunk| # rubocop:todo Lint/EmptyBlock
            end
          end
        end
      end
    end
  end
end
