Very simple crud, completely done using the TDD methodology.

installation guide:

1- Download and install ruby 2.6.6 from `https://www.ruby-lang.org/en/downloads/`

2 - Clone the repository: `git clone git@github.com:gustavomendess/tdd-repo.git`

3 - Install the gems: `bundle install` or `bundle`

4 - run `bin/rails db:create db:migrate`

To run the system:

`bin/rails -b 0.0.0.0`

To run the tests:

`bin/rspec`

It is always preferable to use it from the bin folder, as it uses the rspec from the binaries folder of the rails installation, making execution faster.
