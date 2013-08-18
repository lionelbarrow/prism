module Prism
  class ExampleGroupList
    include Enumerable

    def initialize(prism_config, list)
      @config = prism_config
      @inner_list = list.map { |i| ExampleGroupWrapper.new(@config, i) }
    end

    def each(&block)
      @inner_list.each { |e| block.call(e) }
    end

    def <<(other)
      @inner_list << ExampleGroupWrapper.new(@config, other)
    end

    def size
      @inner_list.size
    end
  end
end
