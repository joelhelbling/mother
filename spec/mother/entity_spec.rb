RSpec.describe Mother::Entity do
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

      Then { expect(subject.foo).to be_a(described_class) }
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
end
