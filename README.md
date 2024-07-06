# TestProject

This is just a playground for me to monkey around. You an safely ignore things here.

## Install

```
brew install terminal-notifier

asdf install # install ruby
bundle
```

## Running

```
be ruby lib/test_project.rb
```

## Tests

### Automatic background runner
```
be guard
```

### Manually
If you need to run only one file or only one test, change that test to use `fit`, `fdescribe`, or `fcontext`, then `be rspec` will just do the right thing.

```
be rspec
```
