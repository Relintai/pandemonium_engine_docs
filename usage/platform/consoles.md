

Console support in Pandemonium
========================

Console publishing process
--------------------------

Regardless of the engine used to create the game, the process to publish a game
to a console platform is as follows:

- Register a developer account on the console manufacturer's website, then sign
  NDAs and publishing contracts. This requires you to have a registered legal
  entity.
- Gain access to the publishing platform by passing the acceptance process. This
  can take up to several months. Note that this step is significantly easier if
  an established publisher is backing your game. Nintendo is generally known to
  be more accepting of smaller developers, but this is not guaranteed.
- Get access to developer tools and order a console specially made for
  developers (*devkit*). The cost of those devkits is confidential.
- Port the engine to the console platform or pay a company to do it.
- To be published, your game needs to be rated in the regions you'd like to sell
  it in. For example, in North America, the `ESRB ( https://www.esrb.org/ )`
  handles game ratings. In Europe, this is done by
  `PEGI ( https://pegi.info/ )`. Indie developers can generally get a rating
  for cheaper compared to more established developers.

Due to the complexity of the process, the budget to publish a game by yourself on a
single console often exceeds $1,000 (this is a rough figure).

Official support
----------------

Pandemonium supports the Linux-based Steam Deck. The reason other consoles are not
officially supported are:

- To develop for consoles, one must be licensed as a company.
  As an open source project, Pandemonium does not have such a legal figure.
- Console SDKs are secret and covered by non-disclosure agreements.
  Even if we could get access to them, we could not publish
  the platform-specific code under an open source license.
- Consoles require specialized hardware to develop for, so regular individuals
  can't create games for them anyway.

However, it is still possible to port your games to consoles thanks to services
provided by third-party companies.

Note:


    In practice, the process is quite similar to Unity and Unreal Engine, except
    that you need to contact a third-party developer to handle the porting
    process. In other words, there is no engine that is legally allowed to
    distribute console export templates without requiring the user to prove that
    they are a licensed console developer. Doing so would violate the console
    manufacturer's NDA.

Third-party support
-------------------

Console ports of Pandemonium are offered by third-party companies (which have
ported Pandemonium on their own). These companies also offer publishing of
your games to various consoles.

Following is the list of providers:

- `Lone Wolf Technology ( http://www.lonewolftechnology.com/ )` offers
  Switch and PS4 porting and publishing of Pandemonium games.
- `Pineapple Works ( https://pineapple.works/ )` offers
  Switch, Xbox One & Xbox Series X/S (GDK) porting and publishing of Pandemonium games (GDScript/C#).
- `RAWRLAB games ( https://www.rawrlab.com/ )` offers
  Switch porting of Pandemonium games.
- `mazette! games ( https://mazette.games/ )` offers
  Switch, Xbox One and Xbox Series X/S porting and publishing of Pandemonium games.

If your company offers porting, or porting *and* publishing services for Pandemonium games,
feel free to
`open an issue or pull request ( https://github.com/pandemoniumengine/pandemonium-docs )`
to add your company to the list above.
