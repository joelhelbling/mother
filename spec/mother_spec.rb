RSpec.describe Mother do
  describe '#create' do
    When(:subject) { described_class.create arg }

    context 'with hash' do
      Given(:arg) { { foo: 'bar' } }

      Then { expect(subject).to be_a(Mother) }
    end

    context 'with array' do
      Given(:arg) { [:a, {b: 'bee'}] }

      Then { expect(subject).to be_a(Mother::Collection) }
    end

    context 'with another Mother' do
      Given(:arg) { described_class.new({a: 'b'}) }

      Then { subject === arg }
    end

    context 'with Mother::Collection' do
      When(:arg) { Mother::Collection.new(described_class, [:a, {b: 'bee'}]) }

      Then { subject === arg }
    end

    context 'with file name', :use_fakefs do
      Given(:hash) do
        { foo: 'phew', bar: 'baer' }
      end

      context '.yaml' do
        Given(:arg) { 'my.yaml' }
        Given { write_yaml arg, hash }

        Then { expect(subject).to be_a(Mother) }
      end

      context '.yml' do
        Given(:arg) { 'my.yml' }
        Given { write_yaml arg, hash }

        Then { expect(subject).to be_a(Mother) }
      end

      context '.json' do
        Given(:arg) { 'my.json' }
        Given { write_json arg, hash }

        Then { expect(subject).to be_a(Mother) }
      end
    end

    context 'with some other string' do
      Given(:arg) { 'some string' }

      Then { subject === arg }
    end

    context 'with a number' do
      Given(:arg) { 12 }

      Then { subject === arg }
    end
  end

  describe '#initialize' do
    Given(:hash) do
      { foo: 'phew', bar: 'baer' }
    end

    context 'when argument is a hash' do
      Given(:argument) { hash }
      When(:subject) { described_class.new argument }
      Then { subject.foo == hash[:foo] }
    end

    context 'invalid arguments' do
      context 'like a String' do
        Given(:arg) { 'foo, um, bar' }
        Then do
          expect{ described_class.new arg }.to raise_error(ArgumentError)
        end
      end
      context 'an Integer' do
        Given(:arg) { 12 }
        Then do
          expect{ described_class.new arg }.to raise_error(ArgumentError)
        end
      end
    end
  end

  describe 'children' do
    When(:subject) { described_class.new argument }

    context 'who are hashes' do
      Given(:argument) { { foo: { bar: 'bing' } } }

      Then { expect(subject.foo).to be_a(Mother) }
    end

    context 'who are arrays' do
      Given(:argument) { { foo: [ :bar, :baz, { bop: 12 } ] } }

      Then { expect(subject.foo).to be_a(Mother::Collection) }
    end

    context 'who happen to be mothers' do
      Given(:argument) { { foo: described_class.new({bar: 'bing'}) } }

      Then { expect(subject.foo).to be_a(described_class) }
    end
  end

  describe '#keys' do
    Given(:argument) { { foo: 'phew', bar: 'boar' } }
    When(:subject) { described_class.new argument }
    Then { subject.keys == [:foo, :bar] }
  end

  describe '#values' do
    Given(:argument) { { foo: 'phew', bar: 'boar' } }
    When(:subject) { described_class.new argument }
    Then { subject.values == ['phew', 'boar'] }
  end
end
