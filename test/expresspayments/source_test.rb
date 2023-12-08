# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class SourceTest < Test::Unit::TestCase
    should "be retrievable" do
      source = ExpressPayments::Source.retrieve("src_123")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/sources/src_123"
      assert source.is_a?(ExpressPayments::Source)
    end

    should "be creatable" do
      source = ExpressPayments::Source.create(
        type: "card",
        token: "tok_123"
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/sources"
      assert source.is_a?(ExpressPayments::Source)
    end

    should "be saveable" do
      source = ExpressPayments::Source.retrieve("src_123")
      source.metadata["key"] = "value"
      source.save
      assert_requested :post, "#{ExpressPayments.api_base}/v1/sources/#{source.id}"
    end

    should "be updateable" do
      source = ExpressPayments::Source.update("src_123", metadata: { foo: "bar" })
      assert_requested :post, "#{ExpressPayments.api_base}/v1/sources/src_123"
      assert source.is_a?(ExpressPayments::Source)
    end

    context "#detach" do
      should "not be deletable when unattached" do
        source = ExpressPayments::Source.retrieve("src_123")

        assert_raises NotImplementedError do
          source.detach
        end
      end

      should "be deletable when attached to a customer" do
        source = ExpressPayments::Source.construct_from(customer: "cus_123",
                                                        id: "src_123",
                                                        object: "source")
        source = source.detach
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/customers/cus_123/sources/src_123"
        assert source.is_a?(ExpressPayments::Source)
      end
    end

    should "not be listable" do
      assert_raises NoMethodError do
        ExpressPayments::Source.list
      end
    end

    context "#verify" do
      should "verify the source" do
        source = ExpressPayments::Source.retrieve("src_123")
        source = source.verify(values: [1, 2])
        assert_requested :post,
                         "#{ExpressPayments.api_base}/v1/sources/#{source.id}/verify",
                         body: { values: [1, 2] }
        assert source.is_a?(ExpressPayments::Source)
      end
    end

    context ".verify" do
      should "verify the source" do
        source = ExpressPayments::Source.verify("src_123", values: [1, 2])
        assert_requested :post,
                         "#{ExpressPayments.api_base}/v1/sources/src_123/verify",
                         body: { values: [1, 2] }
        assert source.is_a?(ExpressPayments::Source)
      end
    end

    context ".list_source_transactions" do
      should "list source transactions" do
        ExpressPayments::Source.list_source_transactions(
          "src_123"
        )
        assert_requested :get, "#{ExpressPayments.api_base}/v1/sources/src_123/source_transactions"
      end
    end

    context "#source_transactions" do
      should "list source transactions" do
        old_stderr = $stderr
        $stderr = StringIO.new

        begin
          source = ExpressPayments::Source.construct_from(id: "src_123",
                                                          object: "source")
          source.source_transactions
          assert_requested :get, "#{ExpressPayments.api_base}/v1/sources/src_123/source_transactions"

          assert_include $stderr.string,
                         "use Source.list_source_transactions instead"
        ensure
          $stderr = old_stderr
        end
      end
    end
  end
end
