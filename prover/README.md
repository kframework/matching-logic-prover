After cloning this repository, run `git submodule update --init`. Then, run
`./build`. To run unit tests only, run `./build unit-tests`. To run tests in the
`t/` directory run `./build t/foo.test` (e.g.
`t/lsegleft-implies-lsegright.prover.test`). To create a new test, edit the
`lib/build.py` file and add a call to `do_test` with the appropriate expected
output.
