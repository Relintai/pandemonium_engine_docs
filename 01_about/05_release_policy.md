

# Pandemonium release policy

Pandemonium's release policy is in constant evolution. What is described below is
intended to give a general idea of what to expect, but what will actually
happen depends on the choices of core contributors, and the needs of the
community at a given time.

## Pandemonium versioning

Pandemonium loosely follows `Semantic Versioning ( https://semver.org/ )` with a
`major.minor.patch` versioning system, albeit with an interpretation of each
term adapted to the complexity of a game engine:

- The `major` version is incremented when major compatibility breakages happen
  which imply significant porting work to move projects from one major version
  to another.

  For example, porting Pandemonium projects from Pandemonium 2.1 to Pandemonium 3.0 required
  running the project through a conversion tool, and then performing a number
  of further adjustments manually for what the tool could not do automatically.

- The `minor` version is incremented for feature releases which do not break
  compatibility in a major way. Minor compatibility breakage in very specific
  areas *may* happen in minor versions, but the vast majority of projects
  should not be affected or require significant porting work.

  The reason for this is that as a game engine, Pandemonium covers many areas such
  as rendering, physics, scripting, etc., and fixing bugs or implementing new
  features in a given area may sometimes require changing the behavior of a
  feature, or modifying the interface of a given class, even if the rest of
  the engine API remains backwards compatible.

Tip:


    Upgrading to a new minor version is therefore recommended for all users,
    but some testing is necessary to ensure that your project still behaves as
    expected in a new minor version.

- The `patch` version is incremented for maintenance releases which focus on
  fixing bugs and security issues, implementing new requirements for platform
  support, and backporting safe usability enhancements. Patch releases are
  backwards compatible.

  Patch versions may include minor new features which do not impact the
  existing API, and thus have no risk of impacting existing projects.

Tip:


    Updating to new patch versions is therefore considered safe and strongly
    recommended to all users of a given stable branch.

We call `major.minor` combinations *stable branches*. Each stable branch
starts with a `major.minor` release (without the `0` for `patch`) and is
further developed for maintenance releases in a Git branch of the same name
(for example patch updates for the 3.3 stable branch are developed in the
`3.3` Git branch).

Note:


    As mentioned in the introduction, Pandemonium's release policy is evolving, and
    earlier Pandemonium releases may not have followed the above rules to the letter.
    In particular, the 3.2 stable branch received a number of new features in
    3.2.2 which would have warranted a `minor` version increment.

## Release support timeline

Stable branches are supported *at minimum* until the next stable branch is
released and has received its first patch update. In practice, we support
stable branches on a *best effort* basis for as long as they have active users
who need maintenance updates.

Whenever a new major version is released, we make the previous stable branch a
long-term supported release, and do our best to provide fixes for issues
encountered by users of that branch who cannot port complex projects to the new
major version. This was the case for the 2.1 branch, and will be the case for
the latest 3.x stable branch by the time Pandemonium 4.0 is released.

In a given minor release series, only the latest patch release receives support.
If you experience an issue using an older patch release, please upgrade to the
latest patch release of that series and test again before reporting an issue
on GitHub.

**Legend:**
![supported](img/supported.png) Full support –
![partial](img/partial.png) Partial support –
![eol](img/eol.png) No support (end of life) –
![unstable](img/unstable.png) Development version

Pre-release Pandemonium versions aren't intended to be used in production and are
provided for testing purposes only.


## When is the next release out?

While Pandemonium contributors aren't working under any deadlines, we strive to
publish minor releases relatively frequently, with an average of two 3.x minor
releases per year since Pandemonium 3.3.

Maintenance (patch) releases are released as needed with potentially very
short development cycles, to provide users of the current stable branch with
the latest bug fixes for their production needs.

As for the upcoming Pandemonium 4.0, as of August 2022, we are aiming for a *beta*
release in Q3 2022, and possibly a stable release by Q4 2022 (but experience
has shown time and time again that such estimates tend to be overly optimistic).
`Follow the Pandemonium blog ( https://pandemoniumengine.org/news )` for the latest updates.
