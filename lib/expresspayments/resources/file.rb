# File generated from our OpenAPI spec
# frozen_string_literal: true

module ExpressPayments
  # This object represents files hosted on ExpressPayments' servers. You can upload
  # files with the [create file](https://docs.epayments.network/api#create_file) request
  # (for example, when uploading dispute evidence). ExpressPayments also
  # creates files independently (for example, the results of a [Sigma scheduled
  # query](https://docs.epayments.network/api#scheduled_queries)).
  #
  # Related guide: [File upload guide](https://docs.epayments.network/file-upload)
  class File < APIResource
    extend ExpressPayments::APIOperations::Create
    extend ExpressPayments::APIOperations::List

    OBJECT_NAME = "file"

    # This resource can have two different object names. In latter API
    # versions, only `file` is used, but since expresspayments-ruby may be used with
    # any API version, we need to support deserializing the older
    # `file_upload` object into the same class.
    OBJECT_NAME_ALT = "file_upload"

    def self.resource_url
      "/v1/files"
    end

    def self.create(params = {}, opts = {})
      if params[:file] && !params[:file].is_a?(String) && !params[:file].respond_to?(:read)
        raise ArgumentError, "file must respond to `#read`"
      end

      config = opts[:client]&.config || ExpressPayments.config
      opts = {
        api_base: config.uploads_base,
        content_type: MultipartEncoder::MULTIPART_FORM_DATA,
      }.merge(Util.normalize_opts(opts))
      super
    end
  end
end
