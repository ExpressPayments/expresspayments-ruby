# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class CustomerTest < Test::Unit::TestCase
    should "be listable" do
      customers = ExpressPayments::Customer.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/customers"
      assert customers.data.is_a?(Array)
      assert customers.first.is_a?(ExpressPayments::Customer)
    end

    should "be retrievable" do
      customer = ExpressPayments::Customer.retrieve("cus_123")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/customers/cus_123"
      assert customer.is_a?(ExpressPayments::Customer)
    end

    should "be creatable" do
      customer = ExpressPayments::Customer.create
      assert_requested :post, "#{ExpressPayments.api_base}/v1/customers"
      assert customer.is_a?(ExpressPayments::Customer)
    end

    should "be saveable" do
      customer = ExpressPayments::Customer.retrieve("cus_123")
      customer.metadata["key"] = "value"
      customer.save
      assert_requested :post, "#{ExpressPayments.api_base}/v1/customers/#{customer.id}"
    end

    should "be updateable" do
      customer = ExpressPayments::Customer.update("cus_123", metadata: { key: "value" })
      assert_requested :post, "#{ExpressPayments.api_base}/v1/customers/cus_123"
      assert customer.is_a?(ExpressPayments::Customer)
    end

    context "#delete" do
      should "be deletable" do
        customer = ExpressPayments::Customer.retrieve("cus_123")
        customer = customer.delete
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/customers/#{customer.id}"
        assert customer.is_a?(ExpressPayments::Customer)
      end
    end

    context ".delete" do
      should "be deletable" do
        customer = ExpressPayments::Customer.delete("cus_123")
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/customers/cus_123"
        assert customer.is_a?(ExpressPayments::Customer)
      end
    end

    context "#delete_discount" do
      should "delete a discount" do
        customer = ExpressPayments::Customer.retrieve("cus_123")
        discount = customer.delete_discount
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/customers/cus_123/discount"
        assert discount.is_a?(ExpressPayments::Discount)
      end
    end

    context ".delete_discount" do
      should "delete a discount" do
        discount = ExpressPayments::Customer.delete_discount("cus_123")
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/customers/cus_123/discount"
        assert discount.is_a?(ExpressPayments::Discount)
      end
    end

    context "#create_source" do
      should "create a source" do
        ExpressPayments::Customer.create_source(
          "cus_123",
          source: "tok_123"
        )
        assert_requested :post, "#{ExpressPayments.api_base}/v1/customers/cus_123/sources"
      end
    end

    context "#retrieve_source" do
      should "retrieve a source" do
        ExpressPayments::Customer.retrieve_source(
          "cus_123",
          "ba_123"
        )
        assert_requested :get, "#{ExpressPayments.api_base}/v1/customers/cus_123/sources/ba_123"
      end
    end

    context "#update_source" do
      should "update a source" do
        ExpressPayments::Customer.update_source(
          "cus_123",
          "ba_123",
          metadata: { foo: "bar" }
        )
        assert_requested :post, "#{ExpressPayments.api_base}/v1/customers/cus_123/sources/ba_123"
      end
    end

    context "#delete_source" do
      should "delete a source" do
        ExpressPayments::Customer.delete_source(
          "cus_123",
          "ba_123"
        )
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/customers/cus_123/sources/ba_123"
      end
    end

    context "#list_sources" do
      should "list the customer's sources" do
        sources = ExpressPayments::Customer.list_sources(
          "cus_123"
        )
        assert_requested :get, "#{ExpressPayments.api_base}/v1/customers/cus_123/sources"
        assert sources.is_a?(ExpressPayments::ListObject)
        assert sources.data.is_a?(Array)
      end
    end

    context "source field" do
      should "allow setting source with token" do
        c = ExpressPayments::Customer.new("test_customer")
        c.source = "tok_123"
        assert_equal "tok_123", c.source
      end

      should "allow setting source with hash and set flag" do
        c = ExpressPayments::Customer.new("test_customer")
        c.source = {
          object: "card",
        }
        assert_equal true, c.source.save_with_parent
      end
    end

    context "#create_tax_id" do
      should "create a tax id" do
        ExpressPayments::Customer.create_tax_id(
          "cus_123",
          type: "eu_vat",
          value: "11111"
        )
        assert_requested :post, "#{ExpressPayments.api_base}/v1/customers/cus_123/tax_ids"
      end
    end

    context "#retrieve_tax_id" do
      should "retrieve a tax id" do
        ExpressPayments::Customer.retrieve_tax_id(
          "cus_123",
          "txi_123"
        )
        assert_requested :get, "#{ExpressPayments.api_base}/v1/customers/cus_123/tax_ids/txi_123"
      end
    end

    context "#delete_tax_id" do
      should "delete a tax id" do
        ExpressPayments::Customer.delete_tax_id(
          "cus_123",
          "txi_123"
        )
        assert_requested :delete, "#{ExpressPayments.api_base}/v1/customers/cus_123/tax_ids/txi_123"
      end
    end

    context "#list_tax_ids" do
      should "list the customer's tax ids" do
        sources = ExpressPayments::Customer.list_tax_ids(
          "cus_123"
        )
        assert_requested :get, "#{ExpressPayments.api_base}/v1/customers/cus_123/tax_ids"
        assert sources.is_a?(ExpressPayments::ListObject)
        assert sources.data.is_a?(Array)
      end
    end

    context "#create_balance_transaction" do
      should "create a customer balance transaction" do
        ExpressPayments::Customer.create_balance_transaction(
          "cus_123",
          amount: 1234,
          currency: "usd"
        )
        assert_requested :post, "#{ExpressPayments.api_base}/v1/customers/cus_123/balance_transactions"
      end
    end

    context "#retrieve_balance_transaction" do
      should "retrieve a customer balance transaction" do
        ExpressPayments::Customer.retrieve_balance_transaction(
          "cus_123",
          "cbtxn_123"
        )
        assert_requested :get, "#{ExpressPayments.api_base}/v1/customers/cus_123/balance_transactions/cbtxn_123"
      end
    end

    context "#update_balance_transaction" do
      should "update a customer balance transaction" do
        ExpressPayments::Customer.update_balance_transaction(
          "cus_123",
          "cbtxn_123",
          description: "new"
        )
        assert_requested :post, "#{ExpressPayments.api_base}/v1/customers/cus_123/balance_transactions/cbtxn_123"
      end
    end

    context "#list_balance_transactions" do
      should "list the customer balance transactions" do
        sources = ExpressPayments::Customer.list_balance_transactions(
          "cus_123"
        )
        assert_requested :get, "#{ExpressPayments.api_base}/v1/customers/cus_123/balance_transactions"
        assert sources.is_a?(ExpressPayments::ListObject)
        assert sources.data.is_a?(Array)
      end
    end

    context "cash_balance compatibility" do
      # These tests are present for compatibility purposes. Previously the cash
      # balance methods required nil as a second nested_id parameter. The method
      # has been patched to no longer require this, but we want to preserve
      # compatibility for existing users.

      context "#retrieve_cash_balance" do
        should "retrieve with just ID" do
          ExpressPayments::Customer.retrieve_cash_balance("cus_123")
          assert_requested :get, "#{ExpressPayments.api_base}/v1/customers/cus_123/cash_balance"
        end

        should "retrieve with custom opts" do
          # Assert that we're actually making a change by swapping out the API base.
          assert ExpressPayments.api_base != ExpressPayments.connect_base

          ExpressPayments::Customer.retrieve_cash_balance("cus_123", {}, { api_base: ExpressPayments.connect_base })
          assert_requested :get, "#{ExpressPayments.connect_base}/v1/customers/cus_123/cash_balance"
        end
      end

      context "#update_cash_balance" do
        should "update with ID, params" do
          ExpressPayments::Customer.update_cash_balance("cus_123", { settings: { reconciliation_mode: "manual" } })

          assert_requested :post, "#{ExpressPayments.api_base}/v1/customers/cus_123/cash_balance" do |req|
            req.body == "settings[reconciliation_mode]=manual"
          end
        end

        should "update with ID, params and opts" do
          # Assert that we're actually making a change by swapping out the API base.
          assert ExpressPayments.api_base != ExpressPayments.connect_base

          ExpressPayments::Customer.update_cash_balance(
            "cus_123",
            { settings: { reconciliation_mode: "manual" } },
            { api_base: ExpressPayments.connect_base }
          )

          assert_requested :post, "#{ExpressPayments.connect_base}/v1/customers/cus_123/cash_balance" do |req|
            req.body == "settings[reconciliation_mode]=manual"
          end
        end

        should "update with just ID" do
          ExpressPayments::Customer.update_cash_balance("cus_123")

          assert_requested :post, "#{ExpressPayments.api_base}/v1/customers/cus_123/cash_balance"
        end
      end
    end
  end
end