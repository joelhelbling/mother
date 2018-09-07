RSpec.describe 'Mother extended' do

  Given do
    class Mom < Mother
      def [](key)
        case value = super
        when String
          "~~#{value}~~"
        else
          value
        end
      end
    end
  end

  When(:subject) { Mom.create argument }

  describe 'children inherit behaviors' do
    Given(:argument) { { foo: 'bar' } }

    Then { subject.foo == '~~bar~~' }
  end

  describe 'collections are fine too' do
    Given(:argument) { [12, { foo: 'bar' }] }

    Then { subject.last.foo == '~~bar~~' }
  end
end
