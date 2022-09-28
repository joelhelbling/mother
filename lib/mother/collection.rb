class Mother
  class Collection
    attr_reader :mother, :data

    include Enumerable

    def initialize(mother, argument)
      mother.argument_failure! unless argument.is_a?(Array)

      @mother = mother
      @data = argument
    end

    def first
      mother.create data.first
    end

    def last
      mother.create data.last
    end

    def [](index)
      mother.create data[index]
    end

    def each(&block)
      data.map { |i| mother.create i }.each(&block)
    end
  end
end
