# Advent of Code 2025

This year I'm trying out a few Ruby patterns that aren't as common:

- standardrb, to see how I feel about the formatting
- Jim Weirich's block signalling

## Linting

    bundle exec standardrb [--fix]

## Block Signalling

Any block written using braces indicates no side-effects, otherwise
they must use do-end syntax.
