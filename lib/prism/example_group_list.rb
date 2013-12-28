module Prism
  class ExampleGroupList
    include Enumerable

    def initialize(prism_core, list)
      @p = prism_core
      @inner_list = list.map { |i| ExampleGroupWrapper.new(@p, i) }
    end

    def each(&block)
      @inner_list.each { |e| block.call(e) }
    end

    def <<(other)
      @inner_list << ExampleGroupWrapper.new(@p, other)
    end

    def size
      @inner_list.size
    end
  end
end
