# JSExplain

An (unofficial) ECMAScript Reference Interpreter and Double-debugger.

## Installation
To install:
```sh
make init
eval `opam config env`
make
```

You can run the tool locally by opening the ~driver.html~ page.

To test jsjsref using test262:
```sh
make test_init
make test
```
## Testing
To select subsets of tests to run you can use the `-g` flag with the
pattern to grep for in the test name. Each test262 test case's path is
a part of the test name. For example, to select only the interpreter
run test cases for the if statement, you could use:
`npx mocha -g 'test/language/statements/if.*interprets'`

Latest version of jsjsref & debugger is automatically published at:
https://jscert.github.io/jsexplain/branch/master/driver.html

mljsref results are tested online and results published to:
https://psvg.doc.ic.ac.uk/ci/jscert-testing/

## Architecture
The source code for the interpreter is primarily written in a subset of
OCaml with supporting runtime libraries written in both OCaml and JS.

The source code is located in the [jsref](./jsref) directory. It can either be built
using the standard OCaml compiler (to produce a result we term mljsref), or
using a custom OCaml-to-JS compiler which is located in the [generator](./generator)
directory (we term the resulting product jsjsref).

Details about the custom compilation are provided in the generator
directory.

To simplify presentation of the code, a monadic binder syntax extension is
used. This is also described in the generator directory.
