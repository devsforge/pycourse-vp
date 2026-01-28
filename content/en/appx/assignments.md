# Handing in Homework Assignments

## Repository content description

### What to include

-   Code base
-   Project dependencies (if applicable)
-   *(Optional)* Additional project information:
    README, CONTRIBUTING, LICENSE etc.

::: hint
::: title
Hint

Always start new repository from creating `README` and `.gitignore`
files.

### What to exclude

-   Virtual environment, typically `venv` or `env` folder
-   Byte compiled Python code (`__pycache__`)
-   IDE configurations, typically `.vscode` or `.idea` folder
-   Database files, like `db.sqlite3`
-   Other stuff not related to the assignment directly

::: hint
::: title
Hint

Set up **.gitignore** to exclude all name patterns from appending
to the stage area. Common content of this file may look like:

    /venv/
    /env/
    __pycache__/

## Repository initialization

1.  Create and activate virtual environment.
2.  Create common repository files:
    -   README
    -   .gitignore
    -   requirements.txt *(if applicable)*
3.  *(Optional)* Create a code base draft. This can be an empty module
    like **main.py** or an empty Django project <django_init>.
4.  Initialize a new repository using `git init` command.
5.  Set up **.gitignore** name patterns.
6.  Stage your changes.
7.  Commit your changes.
8.  Set up remote repository.
9.  Push changes from local branch to remote.

### Initializing new Django project {#django_init}

Base Django project may be added to the repository with the first commit.
Initialize Django project in current repository root to avoid directories
nesting.

``` shell
$ django-admin startproject <project_name> .
```

!!! important


    Do not forget to create **requirements.txt**.


After that, you may proceed with \"staging\" and \"commit\" steps.

## Sharing project dependencies

The **requirements.txt** file is a plain text file that lists all the Python
packages required for a specific project. This file is used to specify
dependencies in a version-controlled and easily shareable manner. It allows
for a consistent environment across different team members\' local setups.

### Where to place \"requirements.txt\" file

The **requirements.txt** file is generally placed in the root directory of
the project.

### Creating \"requirements.txt\" file

To generate file use `pip freeze` command and place its output to a file:

``` shell
$ pip freeze > requirements.txt
```

This will create **requirements.txt** file. Its content may look like:

    asgiref==3.6.0
    Django==4.1.5
    psycopg2==2.9.5
    sqlparse==0.4.3
    tzdata==2022.7

### Installing dependencies from \"requirements.txt\" file

Another team member may easily install all the requirements for the project
by using `pip install` command:

``` shell
$ pip install -r requirements.txt
```

## Dealing with home tasks (challenges)

1.  Create a new topic branch
2.  Switch to a topic branch
3.  Do the work and commit changes

::: hint
::: title
Hint

You can create a new branch and immediately switch to it:

``` shell
git checkout -b <new_branch>
```

### Creating a pull request

1.  Make sure your working branch is up-to-date with the default one.
    You can pull changes for the default branch and rebase your feature
    branch onto it.

2.  Push feature branch to the remote repository. By default, the current
    active branch is pushed via `git push` command. You may need to
    set upstream branch if it isn\'t yet.

    ``` shell
    git push -u origin <remote_branch>
    ```

3.  Navigate to your remote repository homepage on GitHub and switch to
    **Pull requests** tab.

4.  Click **New pull request** button.

5.  Select your default branch as *target* and your feature branch as
    *source*.

6.  Click **Create pull request** button.

7.  Provide meaningful title and a brief description for your pull request.

8.  Submit pull request creation.

9.  *(Optional)* Select reviewer(s) in **Reviewers** section.

10. Wait until your pull request is reviewed.

### Set up reviewers

You may share a link to pull request to a reviewer directly, but it\'s better
to set reviewer(s) on the pull request\'s page.
Before you can select reviewers, you need to add them as project contributors.

#### Append collaborators

Reviews allow collaborators to comment on the changes proposed in pull
requests, approve the changes, or request further changes before the pull
request is merged. Repository administrators can require that pull requests
are approved before being merged.

1.  Navigate to your repository homepage on GitHub and switch to **Settings**
    tab.
2.  Select **Collaborators and teams** menu item.
3.  Under **Manage access** section click **Add people** button.
4.  In modal window start typing GitHub username.
5.  Select a contributor from the dropdown menu.

This will send a *contributing request* to a specified user.

### Merging changes

In case your pull request is **approved** - merge it to the trunk branch.
Select one of the options available:

-   Create a merge commit
-   Rebase and merge
-   Squash and merge

**Create a merge commit** suits in most of the cases.

### Making changes

In case your pull request is **rejected** or has comments - you may need to
provide some fixes.

1.  Do the work in your local topic branch
2.  Push these changes to remote
3.  Re-request review (if applicable)
4.  Wait until review is done
