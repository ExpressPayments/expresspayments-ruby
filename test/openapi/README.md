## Using custom OpenAPI specification and fixtures files

You can place custom OpenAPI specification and fixtures files in this
directory. The files must be in JSON format, and must be named `spec3.json`
and `fixtures3.json` respectively.

If those files are present, the test suite will start its own expresspayments-mock
process on a random available port. In order for this to work, `expresspayments-mock`
must be on the `PATH` in the environment used to run the test suite.
