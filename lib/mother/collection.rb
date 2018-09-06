module Mother
  class Collection
    include Enumerable
    include Mother::Common

    def initialize(argument)
      ___argument_failure! unless argument.is_a?(Array)

      @data = argument
    end

    def first
      ___create @data.first
    end

    def last
      ___create @data.last
    end

    def [](index)
      ___create @data[index]
    end

    def each(&block)
      @data.map{ |i| ___create i }.each(&block)
    end
  end
end
