use SBOM::subsets:ver<0.0.1>:auth<zef:lizmat> <
  PositiveInt
>;

use SBOM:ver<0.0.1>:auth<zef:lizmat>;

#- Frame -----------------------------------------------------------------------
#| Within a call stack, a frame is a discrete unit that encapsulates
#| an execution context, including local variables, parameters, and
#| the return address. As function calls are made, frames are pushed
#| onto the stack, forming an array-like structure that orchestrates
#| the flow of program execution and manages the sequence of function
#| invocations.
class SBOM::Frame:ver<0.0.1>:auth<zef:lizmat> does SBOM {

#| A package organizes modules into namespaces, providing a unique
#| namespace for each type it contains.
    has Str $.package;

#| A module or class that encloses functions/methods and other code.
    has Str $.module is required;

#| A block of code designed to perform a particular task.
    has Str $.function;

#| Optional arguments that are passed to the module or function.
    has Str @.parameters;

#| The line number the code that is called resides on.
    has PositiveInt $.line;

#| The column the code that is called resides.
    has PositiveInt $.column;

#| The full path and filename of the module.
    has Str $.fullFilename;
}

#- Callstack -------------------------------------------------------------------
#| Evidence of component use through the callstack.
class SBOM::Callstack:ver<0.0.1>:auth<zef:lizmat> does SBOM {

#| The frames seen in the callstack.
    has SBOM::Frame @.frames;
}

# vim: expandtab shiftwidth=4
