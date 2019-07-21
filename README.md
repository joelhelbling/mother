In the culinary world, "mother" is a natural complex of bacteria, proteins, enzymes and
fiber, which controls the fermentation of vinegar.  It has this property, that the mother
derived in a new batch of vinegar can subsequently be used to start the fermentation of
yet another batch.

This gem proposes a similar arrangement, wherein a hash-like map or object comprises the
un-fermented source, while Mother (the ruby gem) provides a "fermented" abstraction which
1) provides convenient access to the hash's properties, and
2) generates a new Mother for any accessed property which is, itself, another hash, so
that hashes of hashes, once mothered, will yield children who are also mothers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mother'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mother

See?  Not so bad.

## Usage

Mother is easy to use.  If you have a hash like so:

```ruby
source = {
  favorite_beverage: 'Chamomile Tea'
}
```

Then create a Mother like so:

```ruby
mom = Mother.create source
```

And then you can call your mom (and you should!):

```ruby
mom.favorite_beverage #=> 'Chamomile Tea'
```

### Mother from another resource

Mothers can create from hashes, but also from two popular hash-like file types, namely
YAML and JSON.  These things will work (assuming the files actually exist):

```ruby
mom = Mother.create 'math/theorems.yml'
mom = Mother.create './space_program.yaml'
mom = Mother.create '/opt/var/kids/birthdays.json'
```

### My what big hashes you have!

As mentioned earlier, Mothers can be grandmothers.  Let's expand our earlier hash:

```ruby
source = {
  daughter: {
    favorite_beverage: 'Gen Macha Tea'
  }
}
```

Then create a (grand)Mother just like we did before:

```ruby
mom = Mother.create source
```

And then we find that the daughter is also a Mother:

```ruby
mom.daughter.class #=> Mother
```

And indeed can be called in the same way:

```ruby
mom.daughter.favorite_beverage #=> 'Gen Macha Tea'
```

### There was an old woman who lived in a shoe...

Mothers can also have whole broods of children (in Ruby these are called arrays),
any of which could be mothers:

```ruby
source = {
  brood: [
    12,
    'orange',
    {
      favorite_band: 'BTS'
    }
  ]
}
```

We create the mother as usual:

```ruby
mom = Mother.create source
```

And then we find that we can access the array of children:

```ruby
mom.brood.first              #=> 12
mom.brood[1]                 #=> 'orange'
mom.brood.last.class         #=> Mother
mom.brood.last.favorite_band #=> 'BTS'
```

### What About Demeter

At this point, I'd like to give a cheery halo to Demeter, the Greek mother goddess of
harvest, grain, and Persephone.  You may be familiar with the programming principle to
which she has lent her name, namely the Law of Demeter, also known as the Principle of
Least Knowledge.  According to this sage law, don't do this:

```ruby
thing_1.thing_2.thing_that_thing_2_can_do(plenty, of: arguments)
```

All those dots mean that our code, rather than just contenting itself with knowning how
to use thing_1, must also be inculcated with the proper use of thing_2.  Bleh!

Law of Demeter violations are Bad &trade;, and you'll die if you use 'em.  But in this
case, let's relax our customary parsimony and play around with them a bit!

I propose some guidelines:

 - to keep things easy to reason about, consider not mutating your motherized hashes.  Just
   treat them like facts which don't change.
 - avoid accessing them very deeply in any given context.  Instead of calling the daughter
   from the mother, and daisy-chaining calls to the daughter's attributes, instead hand
   the daughter to another object, which can then access the daughter's attributes.
 - don't worry so much.

The use case for which I dreamed this gem up was that I wanted to collect all my magical
values for a 2D game into a single YAML config file, and then be able to easily distribute
the subsections to various objects within the game, and to provide easy, method-like
access to all the properties (like they get to do with objects in JavaScript).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec`
to run the tests. You can also run `bin/console` for an interactive prompt that will allow
you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a
new version, update the version number in `version.rb`, and then run `bundle exec rake release`,
which will create a git tag for the version, push git commits and tags, and push the `.gem`
file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joelhelbling/mother.
This project is intended to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [code of conduct][code_of_conduct].

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Dedication

_I'd like to dedicate this gem to my Mom, who taught me to think analytically, who was my first
and best math teacher, and who encourages me to do my best, even nowadays.  I love you, Mom._

[code_of_conduct]: https://github.com/joelhelbling/mother/blob/master/CODE_OF_CONDUCT.md
