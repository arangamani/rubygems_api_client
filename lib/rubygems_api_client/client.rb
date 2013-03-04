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
require 'rest-client'
require 'json'


module RubygemsApi
  class Client

    BASE_URL = "https://rubygems.org/api/v1"
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

    def activity
      RubygemsApi::Client::Activity.new(self)
    end

    def downloads
      RubygemsApi::Client::Downloads.new(self)
    end

    def gems
      RubygemsApi::Client::Gems.new(self)
    end

    def versions
      RubygemsApi::Client::Versions.new(self)
    end

    def owners
      RubygemsApi::Client::Owners.new(self)
    end

    def web_hooks
      RubygemsApi::Client::WebHooks.new(self)
    end

    def get(resource_url, params = nil)
      hash = {}
      hash = {"Authorization" => @api_key} if @api_key
      hash.merge!({:params => params})
      to_get = "#{BASE_URL}/#{resource_url}"
      puts "[INFO] GET #{to_get}, #{params.inspect}"
      response = RestClient.get(to_get, hash)
      JSON.load(response)
    end

    def get_paginated(resource_url, params = nil)
      matches = []
      page = 1
      while true
        response = get(resource_url, params.merge!({:page => page}))
        break if response.length == 0
        matches += response
        page += 1
      end
      matches
    end

    def post(resource_url, payload, params = nil)
      hash = {}
      hash = {"Authorization" => @api_key} if @api_key
      hash.merge!({:params => params})
      hash.merge!({:content_length => 0}) if payload.nil?
      to_get = "#{BASE_URL}/#{resource_url}"
      puts "[INFO] POST #{to_get}, #{params.inspect}"
      response = RestClient.post(to_get, payload, hash)
      response
    end

    def put(resource_url, payload = nil, params = nil)
      hash = {}
      hash = {"Authorization" => @api_key} if @api_key
      hash.merge!({:params => params})
      hash.merge!({:content_length => 0}) if payload.nil?
      to_get = "#{BASE_URL}/#{resource_url}"
      puts "[INFO] PUT #{to_get}, #{params.inspect}"
      response = RestClient.put(to_get, payload, hash)
      response
    end

    def delete(resource_url, params = nil)
      hash = {}
      hash = {"Authorization" => @api_key} if @api_key
      hash.merge!({:params => params})
      to_get = "#{BASE_URL}/#{resource_url}"
      puts "[INFO] DELETE #{to_get}, #{params.inspect}"
      response = RestClient.delete(to_get, hash)
      response
    end

  end
end
