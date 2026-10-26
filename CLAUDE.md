# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

bp3-paper_trail adapts `paper_trail` for BP3 (persuavis/black_phoebe_3), a multi-site multi-tenant Rails
application. It makes every `has_paper_trail` model write its versions to the application's own version
class, and makes `PaperTrail::Version` searchable and displayable.

## Commands

The gems run on Ruby 3.4.6 (`.ruby-version`). Prefix commands with `~/.rvm/bin/rvm 3.4.6 do` when the
shell is not already on it; a missing `rspec` means the wrong Ruby, not a missing bundle.

- `bundle exec rake` - specs and RuboCop (the default task)
- `bundle exec rspec spec/path/to/file_spec.rb[:LINE]` - one file or example
- `bundle exec rubocop` / `bundle exec rubocop -a`
- `bin/setup`, `bin/console`, `rake install`

## Architecture

`lib/bp3/paper_trail/railtie.rb`, in an `after_initialize` block:

- reopens `PaperTrail::ModelConfig#version_class` to return `Bp3::PaperTrail.version_class`, whatever
  `version_class_name` a model passed to `has_paper_trail`
- includes `Bp3::Core::Ransackable` and `Bp3::Core::Displayable` in `PaperTrail::Version`.
  `Displayable#filtered_attributes` masks filtered parameters in `object` and `object_changes`

**Configuration** (`lib/bp3/paper_trail.rb`): `Bp3::PaperTrail.version_class_name`, set in the
application's `config/initializers/bp3-paper_trail.rb` to `'Version'`; `.version_class` constantizes and
caches it. The application's controllers fill the version's tenancy and request columns through
`Bp3::Core::Actions#info_for_paper_trail`.

## Testing

The spec only checks the version; the Railtie needs a Rails application with a database to exercise. Try a
change against the application (black_phoebe_3) by putting this repo's `lib` ahead of the bundled gem.

## Code Style

- RuboCop (`.rubocop.yml`): target Ruby 3.2.2, NewCops, rubocop-rake and rubocop-rspec; AbcSize 26,
  MethodLength 15, BlockLength 66, ModuleLength 150; `Lint/ConstantDefinitionInBlock` and `Lint/Void`
  are off for `lib/bp3/**/railtie.rb`, where classes are reopened inside a block
- Every file starts with `# frozen_string_literal: true`
- American English; no trailing whitespace on any added or modified line

## Release

Bump `lib/bp3/paper_trail/version.rb` and add a `CHANGELOG.md` entry. `rake release` tags, pushes and
publishes to rubygems.org; leave releasing and committing to the user.
