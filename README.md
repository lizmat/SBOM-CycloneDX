[![Actions Status](https://github.com/lizmat/SBOM-CycloneDX/actions/workflows/linux.yml/badge.svg)](https://github.com/lizmat/SBOM-CycloneDX/actions) [![Actions Status](https://github.com/lizmat/SBOM-CycloneDX/actions/workflows/macos.yml/badge.svg)](https://github.com/lizmat/SBOM-CycloneDX/actions) [![Actions Status](https://github.com/lizmat/SBOM-CycloneDX/actions/workflows/windows.yml/badge.svg)](https://github.com/lizmat/SBOM-CycloneDX/actions)

NAME
====

SBOM::CycloneDX - Software Bill Of Materials, CycloneDX style

SYNOPSIS
========

```raku
use SBOM::CycloneDX;

my $from-path = SBOM::CycloneDX.new($path);  # read from path

my $from-io = SBOM::CycloneDX.new($io);      # read from IO object

my $minimal = SBOM::CycloneDX.new(           # create from named args
  bomFormat   => "CycloneDX",
  specVersion => "1.6"
);
```

DESCRIPTION
===========

`SBOM::CycloneDX` provides a distribution for the implementation of the Software Bill Of Materials standard provided by CycloneDX using the [JSON Reference version 1.6](https://cyclonedx.org/docs/1.6/json/).

SCRIPTS
=======

cyclonedx
---------

    $ cyclonedx t/valid/valid-metadata-tool-1.6.json
    't/valid/valid-metadata-tool-1.6.json' is a valid CycloneDX SBOM

The `cyclonedx` script takes **one** positional argument: the path of a CycloneDX file. It will attempt to load the file and report on any errors seen (if possible). Sets `$!` to `1` if an error occurred, or `0` if all is ok.

Accepts the following optional named arguments:

<table class="pod-table">
<thead><tr>
<th>parameter</th> <th>description</th>
</tr></thead>
<tbody>
<tr> <td>--raw</td> <td>whether to show raw errors</td> </tr> <tr> <td>--silent</td> <td>whether to be silent on success</td> </tr>
</tbody>
</table>

    $ cyclonedx t/valid/valid-metadata-tool-1.6.json --silent
    $ echo $!
    0

cyclonedx-enums
---------------

    $ cyclonedx-enums
    All possible enum classes:

    AccessMode
    Acknowledgement
    ...

    $ cyclonedx-enums AccessMode
    All possible values in the 'AccessMode' enum:

    read-only
    read-write
    ...

The `cyclonedx` script takes **one** optional positional argument: the name of the enum class to display information for. It defaults to `all`, in which case all possible enum classes will be displayed.

Accepts the following optional named arguments:

<table class="pod-table">
<thead><tr>
<th>parameter</th> <th>description</th>
</tr></thead>
<tbody>
<tr> <td>--verbose</td> <td>whether to also show the associated WHY info</td> </tr> <tr> <td>--silent</td> <td>whether to not show headers</td> </tr>
</tbody>
</table>

INTROSPECTION METHODS
=====================

A number of introspection methods will be provided, making it easier to search for certain conditions in a given SBOM. Suggestions for types of introspection are very welcome.

CLASSES PROVIDED
================

All classes can be instantiated by calling the `.new` method with named arguments. Each named argument can either be a `SBOM::` object, or a hash containing named arguments.

SBOM::CycloneDX
---------------

ENUMS PROVIDED
==============

ENUMS API
=========

The `SBOM::enums` module provides a number of functional enum values. Note however that these are **NOT** enums in the pure Raku sense, but Raku classes doing the `Enumify` role. This to allow for an easy check to see whether a given string is allowed for the given "enum".

```raku
use SBOM::enums;  # import *all* enum classes

say ComponentType<application>;  # ComponentType("application")
say ComponentType<foo>;          # Nil

say ComponentType{$name};
```

One can check for the validity of a string for the given enum class by considering it an `Associative`.

```raku
use SBOM::enums <DataFlow>;  # Just import DataFlow enum

say DataFlow.WHY;           # Specifies information about the...
say DataFlow<inbound>.WHY;  # Data that enters a service.
```

If only interested in one or more enum classes, then these can be specified as positional arguments in the `use` statement. If one wants to know what a specific enum class is about, one can call the `WHY` method on it, either on an enum instance (to get information about that particular enum), or on the whole enum class (when called on the enum type).

```raku
use SBOM::enums <DataFlow>;  # Just import DataFlow enum

say DataFlow.keys;  # (bi-directional inbound outbound unknown)
```

The `keys` method can be called on the type object of an enum class to get a sorted list of allowable strings.

```raku
use SBOM::enums <Enumify>;  # Just import Enumify role

say Enumify.keys;   # (AccessMode Acknowledgement Activity...
```

The `keys` method can also be called on the underlying `Enumify` role to obtain a sorted list of the names of all classes of enums available.

CREDITS
=======

The SBOM test files in the `t/valid` directory were taken from [Giuseppe Di Terlizzi's SBOM::CycloneDX repoository](https://github.com/giterlizzi/perl-SBOM-CycloneDX/).

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

COPYRIGHT AND LICENSE
=====================

Copyright 2025 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

