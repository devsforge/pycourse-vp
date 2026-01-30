###############################################################################
                            PYTHON TRAINING COURSE
###############################################################################

This is the training course to master the Python programming language. This
includes the very basics programming topics like data types, variables and
object-oriented programming and advanced topics like multithreading and
web-frameworks for Python.

Repository Structure
====================

The repository uses a locale-based organization for content:

::

    content/                # Content root directory
      _locales/            # Gettext translations (Ukrainian .po files)
      en/                  # Active English content (.rst format)
        *.rst, *.txt       # Lesson files and configuration
        appx/              # Appendices
        basics/            # Python basics
        ...                # Other topic directories
      ru/                  # Legacy Russian content (preserved, not maintained)
        lessons/           # Original lesson files (.md format)
        pictures/          # Images and diagrams for legacy lessons
        README.md          # Explains legacy status

    assets/                # Global project assets (logos, icons, etc.)

**Active Content**: The current English course content is in ``content/en/``.

**Legacy Content**: The ``content/ru/`` directory contains the original
Russian-language course materials from the upstream repository. This content
is preserved for historical reference. See ``content/ru/README.md`` for details.

**Upstream Repository**: https://github.com/PonomaryovVladyslav/PythonCourses.git

Getting started
===============

Getting the sources
-------------------

Current repository is dependent on some other repos (is **multi-repo**).
You may clone it, but this would not download the source of other repos.
To get the full content, do:

.. code-block:: shell

    git clone <this_repo_url> [local_repository]
    # cd into cloned repo and switch to devel branch
    git switch devel
    # clone submodules content
    git submodule update --init --recursive

Installing dependencies
-----------------------

This project comes with dependencies listed in formats suitable for `pip`_
and `poetry`_ package managers. It's recommended to use virtual environment
while working with this project.

To install dependencies via pip do:

.. code-block::

    pip install -r requirements.txt

To do the same using poetry:

.. code-block::

    poetry install

.. _pip: https://pip.pypa.io
.. _poetry: https://python-poetry.org

Building documentation
======================

This repository comes with *Makefile*. For now this is the easiest way to do
anything within this source code. There are several targets defined:

-   ``clean`` will clean up the documentation builds
-   ``html`` will create HTML pages
-   ``locales`` will create/update translations

Just do:

.. code-block:: shell

    make <target>  # e.g. make html

By default all builds are done for english locale.
Define ``LANGUAGE`` environment variable to build documents for other locales.

.. code-block:: shell

    LANGUAGE=uk make html

Using ``make`` without arguments (targets) will clean up documentation and
build HTML pages for *en* and *uk* locales.

.. code-block:: shell

    make

This command is equal to:

.. code-block:: shell

    make clean
    LANGUAGE=en make html
    LANGUAGE=uk make html

Building without make
---------------------

``make`` just automates the build process, however in case you don't have it
installed, you can run builds manually:

.. code-block:: shell

    sphinx-build -b html -D language=en content/en _build/html/en
    sphinx-build -b html -D language=uk content/en _build/html/uk

Contributing to the project
===========================

This is an open-source project, so anyone is welcome to contribute to it.
Please see `contributing guide <./.github/CONTRIBUTING.md>`_ for more details.
