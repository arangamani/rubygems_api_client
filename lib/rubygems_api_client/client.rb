#
# Copyright (c) 2013 Kannan Manickam <arangamani.kannan@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

require 'rubygems'
require 'net/http'
require 'json'


module RubygemsApi
  class Client

    URL = "https://rubygems.org"
    VALID_PARAMS = [
      "api_key",
      "username",
      "password",
      "password_base64"
    ].freeze

    def initialize(args = {})
      args.each do |key, value|
        if value && VALID_PARAMS.include?(key.to_s)
          instance_variable_set("@#{key}", value)
        end
      end if args.is_a? Hash
    end

    def gems
      RubygemsApi::Client::Gems.new(self)
    end

    def downloads
      RubygemsApi::Client::Downloads.new(self)
    end

    def get(resource, query = nil)
      http = Net::HTTP.start("rubygems.org")
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      response = nil
      endpoint = "/api/v1/#{resource}.json"
      endpoint << "?#{query}" unless query.nil?
      if @api_key
        response = http.get2(endpoint, {"Authorization" => @api_key})
      else
        response = http.get2(endpoint)
      end
      JSON.load(response.body)
    end

    def post(resource)

    end

  end
end
