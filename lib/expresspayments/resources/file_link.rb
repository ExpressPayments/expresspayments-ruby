# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # To share the contents of a `File` object with non-ExpressPayments users, you can
  # create a `FileLink`. `FileLink`s contain a URL that you can use to
  # retrieve the contents of the file without authentication.
  class FileLink < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List
    include ExpressPayments::APIOperations::Save

    OBJECT_NAME = "file_link"
  end
end
