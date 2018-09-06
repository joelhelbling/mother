RSpec.describe Mother::Collection do

  describe '#initialize' do
    context 'argument is an array' do
      Given(:argument) do
        [
          { foo: 'phu', bar: 'baz' },
          'a string or so',
          [ :a, :b, { a: 'b' } ]
        ]
      end

      When(:subject) { described_class.new argument }

      Then { expect(subject.first).to be_a(Mother::Entity) }
      Then { expect(subject[1]).to eq('a string or so') }
      Then { expect(subject.last).to be_a(described_class) }
    end

    context 'argument is not an array' do
      context 'String' do
        Given(:argument) { 'whoa yeah, no' }

        Then do
          expect{ described_class.new argument }.to raise_error(ArgumentError)
        end
      end

      context 'Number' do
        Given(:argument) { 12 }

        Then do
          expect{ described_class.new argument }.to raise_error(ArgumentError)
        end
      end
    end

    context '#each' do
      Given(:argument) { [ {}, 'foo', 12 ] }
      When(:subject) { described_class.new argument }
      Then { subject.map{|i| i.class} == [Mother::Entity, String, Integer] }
    end
  end
end
