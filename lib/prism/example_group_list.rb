module Prism
  class ExampleGroupList
    include Enumerable

    def initialize(list)
      @inner_list = list.map { |i| ExampleGroupWrapper.new(i) }
    end

    def each(&block)
      @inner_list.each { |e| block.call(e) }
    end

    def <<(other)
      @inner_list << ExampleGroupWrapper.new(other)
    end

    def size
      @inner_list.size
    end
  end
end
