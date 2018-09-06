RSpec.describe Mother do
  describe '#create' do
    When(:subject) { described_class.create arg }

    context 'with hash' do
      Given(:arg) { { foo: 'bar' } }

      Then { expect(subject).to be_a(Mother::Entity) }
    end

    context 'with array' do
      Given(:arg) { [:a, {b: 'bee'}] }

      Then { expect(subject).to be_a(Mother::Collection) }
    end

    context 'with Mother::Entity' do
      Given(:arg) { Mother::Entity.new({a: 'b'}) }

      Then { subject === arg }
    end

    context 'with Mother::Collection' do
      Given(:arg) { Mother::Collection.new([:a, {b: 'bee'}]) }

      Then { subject === arg }
    end

    context 'with file name', :use_fakefs do
      Given(:hash) do
        { foo: 'phew', bar: 'baer' }
      end

      context '.yaml' do
        Given(:arg) { 'my.yaml' }
        Given { write_yaml arg, hash }

        Then { expect(subject).to be_a(Mother::Entity) }
      end

      context '.yml' do
        Given(:arg) { 'my.yml' }
        Given { write_yaml arg, hash }

        Then { expect(subject).to be_a(Mother::Entity) }
      end

      context '.json' do
        Given(:arg) { 'my.json' }
        Given { write_json arg, hash }

        Then { expect(subject).to be_a(Mother::Entity) }
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
end
