# frozen_string_literal: true

require File.expand_path("../test_helper", __dir__)

module ExpressPayments
  class CreditNoteTest < Test::Unit::TestCase
    should "be listable" do
      credit_notes = ExpressPayments::CreditNote.list
      assert_requested :get, "#{ExpressPayments.api_base}/v1/credit_notes"
      assert credit_notes.data.is_a?(Array)
      assert credit_notes.first.is_a?(ExpressPayments::CreditNote)
    end

    should "be retrievable" do
      credit_note = ExpressPayments::CreditNote.retrieve("cn_123")
      assert_requested :get, "#{ExpressPayments.api_base}/v1/credit_notes/cn_123"
      assert credit_note.is_a?(ExpressPayments::CreditNote)
    end

    should "be creatable" do
      credit_note = ExpressPayments::CreditNote.create(
        amount: 100,
        invoice: "in_123",
        reason: "duplicate"
      )
      assert_requested :post, "#{ExpressPayments.api_base}/v1/credit_notes"
      assert credit_note.is_a?(ExpressPayments::CreditNote)
    end

    should "be saveable" do
      credit_note = ExpressPayments::CreditNote.retrieve("cn_123")
      credit_note.metadata["key"] = "value"
      credit_note.save
      assert_requested :post, "#{ExpressPayments.api_base}/v1/credit_notes/#{credit_note.id}"
    end

    should "be updateable" do
      credit_note = ExpressPayments::CreditNote.update("cn_123", metadata: { key: "value" })
      assert_requested :post, "#{ExpressPayments.api_base}/v1/credit_notes/cn_123"
      assert credit_note.is_a?(ExpressPayments::CreditNote)
    end

    context ".preview" do
      should "preview a credit note" do
        invoice = ExpressPayments::CreditNote.preview(
          invoice: "in_123",
          amount: 500
        )
        assert_requested :get, "#{ExpressPayments.api_base}/v1/credit_notes/preview",
                         query: {
                           invoice: "in_123",
                           amount: 500,
                         }
        assert invoice.is_a?(ExpressPayments::CreditNote)
      end
    end

    context "#void_credit_note" do
      should "void credit_note" do
        credit_note = ExpressPayments::CreditNote.retrieve("cn_123")
        credit_note = credit_note.void_credit_note
        assert_requested :post,
                         "#{ExpressPayments.api_base}/v1/credit_notes/#{credit_note.id}/void"
        assert credit_note.is_a?(ExpressPayments::CreditNote)
      end
    end

    context ".void_credit_note" do
      should "void credit_note" do
        credit_note = ExpressPayments::CreditNote.void_credit_note("cn_123")
        assert_requested :post, "#{ExpressPayments.api_base}/v1/credit_notes/cn_123/void"
        assert credit_note.is_a?(ExpressPayments::CreditNote)
      end
    end

    context ".list_preview_line_items" do
      should "list_preview_line_items" do
        line_items = ExpressPayments::CreditNote.list_preview_line_items(
          invoice: "in_123"
        )
        assert_requested :get, "#{ExpressPayments.api_base}/v1/credit_notes/preview/lines",
                         query: {
                           invoice: "in_123",
                         }
        assert line_items.data.is_a?(Array)
        assert line_items.data[0].is_a?(ExpressPayments::CreditNoteLineItem)
      end
    end
  end
end
