```
webpack cli:
compiler = webpack(options);

webpack:
https://github.com/webpack/webpack/blob/webpack-4/lib/webpack.js#L46
plugins apply

new WebpackOptionsApply().process(options, compiler)
https://github.com/webpack/webpack/blob/webpack-4/lib/WebpackOptionsApply.js#L55

webpack cli:
compiler.run()

webpack:
Compiler.run:
https://github.com/webpack/webpack/blob/webpack-4/lib/Compiler.js#L312
this.hooks.beforeRun.callAsync(this)
this.hooks.run.callAsync(this)
this.readRecords()
this.compile(onCompiled);

Compiler.compile:
https://github.com/webpack/webpack/blob/webpack-4/lib/Compiler.js#L660
const params = this.newCompilationParams()
this.hooks.beforeCompile.callAsync(params)
this.hooks.compile.call(params)
const compilation = this.newCompilation(params)
this.hooks.make.callAsync(compilation)
compilation.finish()
compilation.seal()
this.hooks.afterCompile.callAsync(compilation)

Compilation.seal:
https://github.com/webpack/webpack/blob/webpack-4/lib/Compilation.js#L1283
this.hooks.beforeChunks.call()
...
this.hooks.afterChunks.call(this.chunks)
...
this.hooks.shouldGenerateChunkAssets.call()
Compilation.createChunkAssets:
https://github.com/webpack/webpack/blob/webpack-4/lib/Compilation.js#L2111


```
