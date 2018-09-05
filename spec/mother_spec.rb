RSpec.describe Mother do
  describe '#initialize' do
    Given(:hash) do
      { foo: 'phew', bar: 'baer' }
    end

    context 'when argument is a hash' do
      Given(:argument) { hash }
      When(:subject) { described_class.new argument }
      Then { subject.foo == hash[:foo] }
    end

    context 'when argument is a filename', :use_fakefs do
      When(:subject) { described_class.new argument }

      context 'for a .yaml file' do
        Given(:argument) { 'my.yaml' }
        Given { write_yaml argument, hash }

        Then { subject.foo == hash[:foo] }
      end

      context 'for a .yml file' do
        Given(:argument) { 'my.yml' }
        Given { write_yaml argument, hash }

        Then { subject.foo == hash[:foo] }
      end

      context 'for a .json file'  do
        Given(:argument) { 'my.json' }
        Given { write_json argument, hash }

        Then { subject.foo == hash[:foo] }
      end
    end

    context 'when string is just a string' do
      Given(:argument) { 'foo, um, bar' }
      Then do
        expect{ described_class.new argument }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'children' do
    When(:subject) { described_class.new argument }

    context 'who are hashes' do
      Given(:argument) { { foo: { bar: 'bing' } } }

      Then { expect(subject.foo).to be_a(described_class) }
    end

    context 'who happen to be mothers' do
      Given(:argument) { { foo: described_class.new({bar: 'bing'}) } }

      Then { expect(subject.foo).to be_a(described_class) }
    end
  end
end
