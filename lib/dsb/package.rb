module Dsb
  class Package
    attr_reader :data

    def initialize options
      @client = options[:client]
      @data = options[:data]
      if @data.keys.include? :id
        @resource = "/packages/#{@data[:id]}"
      else
        @resource = "/packages/"
      end
      @changed = false
    end

    def set(field, value)
      if @data.keys.include? field and @data[field] != value
        @data[field] = value
        @changed = true
      end
    end

    def create
      @client.submit_request :resource => @resource,
                             :body => {:package => @data.to_json}
    end

    def save
      if @changed
        @client.submit_request :resource => @resource,
                               :method => :put,
                               :body => {:id => @data[:id],
                                         :package => @data}
      end
    end
  end
end
