# Install Python

The [Python wiki](https://wiki.python.org/moin/BeginnersGuide/Download)
briefly describes the installation process.

!!! note


    To become a **true** professional, you need a special software called
    IDE (Integrated Development Environment) or at least a code
    editor supporting syntax highlight. Refer /appx/code_edit for
    more information.


## Linux

On most Linux distros Python comes pre-installed and/or all distro have it
available in their package repository (I haven\'t seen the one which does have).
The installation process depends on the distro, but here are some examples how
you can install it:

``` {caption="Install Python"}
# Debian / Ubuntu (and other distros that uses ``apt``)
apt install python3 python3-dev

# ArchLinux
pacman -S python3

# RedHat, CentOS, Fedora
dnf install python3 python3-devel

# Gentoo
# ... you should know what to do
```

## MacOS

For newer versions of MacOS Python is no longer included by default and you
will have to download and install it.

The process is described at: [Using Python on a Mac](https://docs.python.org/3/using/mac.html).

Briefly, you are invited to visit [downloads](https://www.python.org/downloads/) and download the latest
stable version of Python. A \"universal binary\" build of Python runs natively on
Mac\'s new Intel and legacy PPC CPUs.

After the installation you would get:

-   [Python 3.x]{.title-ref} folder in [Applications]{.title-ref} folder.
    Standard development environment ([IDLE]{.title-ref}) and [PythonLauncher]{.title-ref} included.
-   A framework [/Library/Frameworks/Python.framework]{.title-ref} included libraries and
    executables.

### Install from Homebrew

Python for MacOS is available via Homebrew. You are to search [formulae](https://formulae.brew.sh/formula/) for
the latest available version. In general, it\'s as easy as:

``` shell
brew install python@3.9
```

## Windows

As for MacOS, here is the official documentation: [Using Python on Windows](https://docs.python.org/3/using/windows.html).

For Windows\' users the stable release is available from [downloads](https://www.python.org/downloads/). Just
download the installer and proceed to common steps to install software.

!!! important


    It\'s recommended to **Add Python3.x to PATH**, this will avoid
    problems at the beginning of your journey with Python


<figure>
<img src="https://docs.python.org/3/_images/win_installer.png" class="align-center" width="600" alt="https://docs.python.org/3/_images/win_installer.png" />
<figcaption>Python installer first page</figcaption>
</figure>

Going on with **Install Now**:

-   Python will be installed to your user directory
-   Python Launcher will be installed according to the option at the bottom
    of the page

Using **Customize installation** will perform an *all-users* installation.

### Removing the MAX_PATH Limitation

Windows historically has limited path lengths to 260 characters. This meant
that paths longer than this would not resolve and errors would result. In the
latest versions of Windows, this limitation can be expanded to approximately
32,000 characters. This allows the open() function, the os module and most
other path functionality to accept and return paths longer than 260 characters.

You will need PC administrator assistance to perform this action.

### Install from the Microsoft Store

You can install from the Microsoft Store in two steps:

1.  Open the Microsoft Store app and search for `Python`
    The result should look like:

    <figure>
    <img src="/../assets/img/microsoft-store-search.png" class="align-center" alt="/../assets/img/microsoft-store-search.png" />
    <figcaption>Microsoft Store - search results for "Python"</figcaption>
    </figure>

    Select `Python 3.9` or the higher available version.

2.  Click **GET** and wait until the installer is downloaded. The installation
    process should run automatically. Follow the installer\'s instructions.

    ![](/../assets/img/microsoft-store-get.png){.align-center}

## Online Interpreters

Installing or updating Python on your computer is the first step to becoming
a Python programmer realpython:install-and-setup.

But if you cannot install Python at the moment for some reason, are can go
with online interpreters. [repl.it](https://replit.com/) provides the ability
to create and store Python scripts (they are called *repl* here) for free.
