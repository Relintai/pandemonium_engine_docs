
# HTML5 shell class reference

Projects exported for the Web expose the `Engine` class to the JavaScript environment, that allows
fine control over the engine's start-up process.

This API is built in an asynchronous manner and requires basic understanding
of [Promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_promises).

## Engine

The `Engine` class provides methods for loading and starting exported projects on the Web. For default export
settings, this is already part of the exported HTML page. To understand practical use of the `Engine` class,
see [Custom HTML page for Web export](01_customizing_html5_shell.md).

#### Static Methods

|         |                                                                          |
|---------|--------------------------------------------------------------------------|
| Promise | `load` **(** string basePath **)**                                     |
| void    | `unload` **(** **)**                                                   |
| boolean | `isWebGLAvailable` **(** *[ number majorVersion=1 ]* **)**             |


#### Instance Methods

|         |                                                                                                                |
|---------|----------------------------------------------------------------------------------------------------------------|
| Promise | `init` **(** *[ string basePath ]* **)**                                     |
| Promise | `preloadFile` **(** string\|ArrayBuffer file *[, string path ]* **)** |
| Promise | `start` **(** EngineConfig override **)**                                   |
| Promise | `startGame` **(** EngineConfig override **)**                           |
| void    | `copyToFS` **(** string path, ArrayBuffer buffer **)**                   |
| void    | `requestQuit` **(** **)**                                             |


```
class: Engine( initConfig )

   Create a new Engine instance with the given configuration.

   param: EngineConfig initConfig:
      The initial config for this instance.

   **Static Methods**

   function: load( basePath )

      Load the engine from the specified base path.

      param: string basePath:
         Base path of the engine to load.

      return:
         A Promise that resolves once the engine is loaded.

      rtype: Promise

   function: unload( )

      Unload the engine to free memory.

      This method will be called automatically depending on the configuration. See `unloadAfterInit`.

   function: isWebGLAvailable( [ majorVersion=1 ] )

      Check whether WebGL is available. Optionally, specify a particular version of WebGL to check for.

      param: number majorVersion:
         The major WebGL version to check for.

      return:
         If the given major version of WebGL is available.

      rtype: boolean

   **Instance Methods**

   function: prototype.init( [ basePath ] )

      Initialize the engine instance. Optionally, pass the base path to the engine to load it,
      if it hasn't been loaded yet. See `Engine.load`.

      param: string basePath:
         Base path of the engine to load.

      return:
         A `Promise` that resolves once the engine is loaded and initialized.

      rtype: Promise

   function: prototype.preloadFile( file [, path ] )

      Load a file so it is available in the instance's file system once it runs. Must be called **before** starting the
      instance.

      If not provided, the `path` is derived from the URL of the loaded file.

      param: string\|ArrayBuffer file:
         The file to preload.

         If a `string` the file will be loaded from that path.

         If an `ArrayBuffer` or a view on one, the buffer will used as the content of the file.

      param: string path:
         Path by which the file will be accessible. Required, if `file` is not a string.

      return:
         A Promise that resolves once the file is loaded.

      rtype: Promise

   function: prototype.start( override )

      Start the engine instance using the given override configuration (if any).
      `startGame` can be used in typical cases instead.

      This will initialize the instance if it is not initialized. For manual initialization, see `init`.
      The engine must be loaded beforehand.

      Fails if a canvas cannot be found on the page, or not specified in the configuration.

      param: EngineConfig override:
         An optional configuration override.

      return:
         Promise that resolves once the engine started.

      rtype: Promise

   function: prototype.startGame( override )

      Start the game instance using the given configuration override (if any).

      This will initialize the instance if it is not initialized. For manual initialization, see `init`.

      This will load the engine if it is not loaded, and preload the main pck.

      This method expects the initial config (or the override) to have both the `executable` and `mainPack`
      properties set (normally done by the editor during export).

      param: EngineConfig override:
         An optional configuration override.

      return:
         Promise that resolves once the game started.

      rtype: Promise

   function: prototype.copyToFS( path, buffer )

      Create a file at the specified `path` with the passed as `buffer` in the instance's file system.

      param: string path:
         The location where the file will be created.

      param: ArrayBuffer buffer:
         The content of the file.

   function: prototype.requestQuit( )

      Request that the current instance quit.

      This is akin the user pressing the close button in the window manager, and will
      have no effect if the engine has crashed, or is stuck in a loop.
```

## Engine configuration

An object used to configure the Engine instance based on pandemonium export options, and to override those in custom HTML
templates if needed.

#### Properties

| type                 | name                          |
|----------------------|-------------------------------|
| boolean              | `unloadAfterInit`    |
| HTMLCanvasElement    | `canvas`             |
| string               | `executable`         |
| string               | `mainPack`           |
| string               | `locale`             |
| number               | `canvasResizePolicy` |
| Array.&lt;string&gt; | `args`               |
| function             | `onExecute`          |
| function             | `onExit`             |
| function             | `onProgress`         |
| function             | `onPrint`            |
| function             | `onPrintError`       |


```
attribute: EngineConfig

   The Engine configuration object. This is just a typedef, create it like a regular object, e.g.:

   `const MyConfig = { executable: 'pandemonium', unloadAfterInit: false }`

   **Property Descriptions**

   attribute: unloadAfterInit

      Whether the unload the engine automatically after the instance is initialized.

      type: boolean

      value: `true`

   attribute: canvas

      The HTML DOM Canvas object to use.

      By default, the first canvas element in the document will be used is none is specified.

      type: HTMLCanvasElement

      value: `null`

   attribute: executable

      The name of the WASM file without the extension. (Set by Pandemonium Editor export process).

      type: string

      value: `""`

   attribute: mainPack

      An alternative name for the game pck to load. The executable name is used otherwise.

      type: string

      value: `null`

   attribute: locale

      Specify a language code to select the proper localization for the game.

      The browser locale will be used if none is specified.

      type: string

      value: `null`

   attribute: canvasResizePolicy

      The canvas resize policy determines how the canvas should be resized by Pandemonium.

      `0` means Pandemonium won't do any resizing. This is useful if you want to control the canvas size from
      javascript code in your template.

      `1` means Pandemonium will resize the canvas on start, and when changing window size via engine functions.

      `2` means Pandemonium will adapt the canvas size to match the whole browser window.

      type: number

      value: `2`

   attribute: args

      The arguments to be passed as command line arguments on startup.

      **Note**: `startGame` will always add the `--main-pack` argument.

      type: Array.&lt;string&gt;

      value: `[]`

   function: onExecute( path, args )

      A callback function for handling Pandemonium's `OS.execute` calls.

      This is for example used in the Web Editor template to switch between project manager and editor, and for running the game.

      param: string path:
         The path that Pandemonium's wants executed.

      param: Array.&lt;string&gt; args:
         The arguments of the "command" to execute.

   function: onExit( status_code )

      A callback function for being notified when the Pandemonium instance quits.

      **Note**: This function will not be called if the engine crashes or become unresponsive.

      param: number status_code:
         The status code returned by Pandemonium on exit.

   function: onProgress( current, total )

      A callback function for displaying download progress.

      The function is called once per frame while downloading files, so the usage of `requestAnimationFrame()`
      is not necessary.

      If the callback function receives a total amount of bytes as 0, this means that it is impossible to calculate.
      Possible reasons include:

      -  Files are delivered with server-side chunked compression
      -  Files are delivered with server-side compression on Chromium
      -  Not all file downloads have started yet (usually on servers without multi-threading)

      param: number current:
         The current amount of downloaded bytes so far.

      param: number total:
         The total amount of bytes to be downloaded.

   function: onPrint( [ ...var_args ] )

      A callback function for handling the standard output stream. This method should usually only be used in debug pages.

      By default, `console.log()` is used.

      param: * var_args:
         A variadic number of arguments to be printed.

   function: onPrintError( [ ...var_args ] )

      A callback function for handling the standard error stream. This method should usually only be used in debug pages.

      By default, `console.error()` is used.

      param: * var_args:
         A variadic number of arguments to be printed as errors.
```

