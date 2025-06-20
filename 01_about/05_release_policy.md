
# Pandemonium release policy

Pandemonium's release policy is in constant evolution. What is described below is
intended to give a general idea of what to expect, but what will actually
happen depends on the choices of core contributors, and the needs of the
community at a given time.

## Pandemonium versioning

Originally Pandemonium continued Godot's [Semantic Versioning](https://semver.org/)
scheme, with a `major.minor.patch` versioning system.

But since new major compatibility breakages are extremely unlikely,
major versions are going to be increased once the minor version gets
above a certain threashold (9).

So this looks like:

- The `major` version is incremented when the `minor` version reaches 10.
  The `minor` version becomes 0 again.
- The `minor` version is incremented for feature releases which do not break
  compatibility in a major way. Minor compatibility breakage in very specific
  areas *may* happen in minor versions, but the vast majority of projects
  should not be affected or require significant porting work.
- The `patch` version is incremented for maintenance releases which focus on
  fixing bugs and security issues, implementing new requirements for platform
  support, and backporting safe usability enhancements. Patch releases are
  backwards compatible.

## Release support timeline

The stable branches on a *best effort* basis for as long as they have active users
who need maintenance updates.

In a given minor release series, only the latest patch release receives support.
If you experience an issue using an older patch release, please upgrade to the
latest patch release of that series and test again before reporting an issue
on GitHub.


## When is the next release out?

Currently a release usually happens about every 3 months. The engine is effectively a one
person project as of now, so this can vary, but so far about 3 mounths ended up the optimal
release window.

Maintenance (patch) releases are released as needed with potentially very
short development cycles, to provide users of the current stable branch with
the latest bug fixes for their production needs.

