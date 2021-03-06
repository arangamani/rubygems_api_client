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

module RubygemsApi
  class Client
    class Gems

      def initialize(client)
        @client = client
      end

      def get_my_gems
        @client.get("gems.json")
      end

      def search(search_string)
        @client.get_paginated("search.json", {:query => search_string})
      end

      def add

      end

      def yank(name, version, platform = nil)
        params = {
          :gem_name => name,
          :version => version,
          :platform => platform
        }
        @client.delete("/gems/yank", params)
      end

      def unyank(name, version, platform = nil)
        params = {
          :gem_name => name,
          :version => version,
          :platform => platform
        }
        @client.put("/gems/unyank", nil, params)

      end

    end
  end
end
