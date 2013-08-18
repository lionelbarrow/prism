module Prism
  class ExampleGroupList
    include Enumerable

    def initialize(list, prism_config)
      @config = prism_config
      @inner_list = list.map { |i| ExampleGroupWrapper.new(i, @config) }
    end

    def each(&block)
      @inner_list.each { |e| block.call(e) }
    end

    def <<(other)
      @inner_list << ExampleGroupWrapper.new(other, @config)
    end

    def size
      @inner_list.size
    end
  end
end
