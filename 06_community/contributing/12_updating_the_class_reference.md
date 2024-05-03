
# Contributing to the class reference


The class reference is available online in the `classes ( toc-class-ref )`
section of the documentation and in the Pandemonium editor, from the help menu.

In the class reference, some methods, variables, and signals lack descriptions.
Others changed with recent releases and need updates. The developers can't write
the entire reference on their own. Pandemonium needs you, and all of us, to
contribute.

**Important:** If you plan to make large changes, you should create an issue on
the `pandemonium-docs repository ( https://github.com/Relintai/pandemonium_engine-docs/ )`
or comment on an existing issue. Doing so lets others know you're already
taking care of a given class.

See also:

    You can find the writing guidelines for the class reference `here ( doc_class_reference_writing_guidelines )`.

    For details on Git usage and the pull request workflow, please
    refer to the `doc_pr_workflow` page.

    If you want to translate the class reference from English to another
    language, see `doc_editor_and_docs_localization`.

    This guide is also available as a `video tutorial on YouTube
    ( https://www.youtube.com/watch?v=5jeHXxeX-JY )`.

See also:


    Not sure which class to contribute to? Take a look at the class reference's
    completion status `here ( https://pandemoniumengine.github.io/doc-status/ )`.

You can find the source files for the class reference in Pandemonium's GitHub
repository: `doc/classes/
( https://github.com/Relintai/pandemonium_engine/tree/master/doc/classes )`.

Note:
 For some modules in the engine's source code, you'll find the XML
          files in the `modules/( module_name>/doc_classes/` directory instead.

Warning:
 Always edit the API reference through these source XML files. Do
             not edit the generated `.rst` files `in the online documentation
             ( toc-class-ref )`, hosted in the `pandemonium-docs
             ( https://github.com/Relintai/pandemonium_engine-docs )` repository.

Warning:


    Unless you make minor changes, like fixing a typo, we do not recommend using the GitHub web editor to edit the class reference's XML.

    It lacks features to edit XML well, like keeping indentations consistent, and it does not allow amending commits based on reviews.

    Also, it doesn't allow you to test your changes in the engine or with validation
    scripts as described in
    `doc_class_reference_writing_guidelines_editing_xml`.

### Updating the documentation template

When you create a new class or modify the engine's API, you need to re-generate the XML files in `doc/classes/`.

To do so, you first need to compile Pandemonium. See the
`doc_introduction_to_the_buildsystem` page to learn how. Then, execute the
compiled Pandemonium binary from the Pandemonium root directory with the `--doctool` option.
For example, if you're on 64-bit Linux, the command is:

```
    ./bin/pandemonium.linuxbsd.tools.64 --doctool
```

The XML files in doc/classes should then be up-to-date with current Pandemonium Engine
features. You can then check what changed using the `git diff` command. Please
only include changes that are relevant to your work on the API in your commits.
You can discard changes in other XML files using `git checkout`.
