# Interacting with Python Interpreter

> It's time to write some Python code!
>
> realpython:interact

In short there are three major ways to do something with Python:

-   interactive Python console
-   running code from file[^1]
-   use online editors (like [repl.it](https://repl.it))

## Using Python interpreter interactively

Using REPL (Read-Eval-Print-Loop) environment is the most straight
forward way to start talking to Python. This simply means starting up the
interpreter and typing commands to it directly realpython:interact.
The interpreter:

-   Reads the command you enter
-   Evaluates and executes it
-   Prints the output (if any) back to the console
-   Loops back and repeats

### Starting the interpreter

In GUI (Graphic User Interface) environment, it\'s likely that the
installer placed a shortcut on the desktop to launch the Python.

For example in Windows the interpreter can be found in the **Start** menu
labeled **Python 3.x**:

<figure>
<img src="/../assets/img/start-menu-python.png" class="align-center" alt="/../assets/img/start-menu-python.png" />
<figcaption>Windows start menu Python group</figcaption>
</figure>

::: hint
::: title
Hint

In case you are getting error saying python is not installed, but you
are sure that the interpreter **is installed** - this means you have
no Python in your `PATH`. Message may look like:
`'python' is not recognized as an internal or external command` /
`python: command not found`

Refer /appx/env_path for problem solution.

The alternative is to launch from a terminal window:

-   **Command Prompt** in Windows
-   **Terminal** both in macOS and Linux

<figure>
<img src="/../assets/img/cmd-python.png" class="align-center" alt="/../assets/img/cmd-python.png" />
<figcaption>Start Python via Command Prompt</figcaption>
</figure>

<figure>
<img src="/../assets/img/terminal-python.png" class="align-center" alt="/../assets/img/terminal-python.png" />
<figcaption>Start Python via Terminal</figcaption>
</figure>

### Running code

Put the Python code in interactive console and press enter to execute it.

1.  Ensure that the `>>>` prompt is displayed and the cursor is pointed after
    it
2.  Type the command `print("Hello, World!")`
3.  Press enter

``` python
print("Hello, World!")
```

Your session should look like:

    print("Hello, World!")
    "Hello, World!"

If you\'ve seen string \"Hello, World!\" printed back, congrats - you\'ve run your
first program in Python.

![image](/../assets/img/celebrate.svg){.align-center width="200px"}

### Exiting the interpreter

To exit the interactive console type \"exit\" and hit enter.

``` python
exit()
```

## Running code from file

A Python script is a reusable set of code. It is essentially a Python program -a sequence of Python instructions - contained in a file. You can run the
program by specifying the name of the script file to the interpreter.

Python scripts are just plain text, so you can edit them with any text editor.
If you have a favorite programmer's editor that operates on text files, it
should be fine to use. Otherwise here are some options for the first time:

-   Windows: ![npp](/../assets/img/npp.svg){width="24px"} [Notepad++](https://notepad-plus-plus.org/)
-   Linux: ![geany](/../assets/img/geany.svg){width="24px"} [Geany](https://www.geany.org/)

Using whatever editor create a script file called `hello.py` and put the code
in it:

``` python
print("Hello, World!")
```

Save file keeping track on the directory you choose to save into. Now, open
the terminal or command prompt in this directory.

::: hint
::: title
Hint

In window you may open Command Prompt in the directory by typing
\"cmd\" to the address bar in explorer.

In the terminal (or command prompt) type:

``` 
python hello.py
```

Python will print string \"Hello, World!\". Your session should look like:

    python hello.py
    Hello, World!

[^1]: Files containing Python code are called *modules*.
