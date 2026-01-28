# GitHub

[GitHub](#github) is the single largest host for Git repositories, and is the central
point of collaboration for millions of developers and projects.

## Account setup and configuration

The first thing you need to do is set up a free user account. Visit [GitHub](#github)
and press \"Sign Up\" button. The GitHub will lead you through the account
creation process. Just follow the hints and provide an email address, username
and a strong password.

### About authentication to GitHub

!!! note


    Starting in March 2023 and through the end of 2023, GitHub gradually began
    to require all users who contribute code on GitHub to enable two-factor
    authentication (2FA).


## Connect with SSH

You can access and write data in repositories on GitHub using
SSH (Secure Shell Protocol). When you connect to via SSH, you
authenticate using a private key file on your local machine.

### Generating a new SSH key

You can generate a new SSH key on your local machine. After you do that,
you can add the **public** key to your account on GitHub to enable
authentication for Git operations over SSH.

1.  Open terminal (git-bash will suite for Windows users)

2.  Run command:

        ssh-keygen -t ed25519 -C "your@email.com"

    ::: note
    ::: title
    Note

    If you are using a legacy system that doesn\'t support the **Ed25519**
    algorithm, use:

        ssh-keygen -t rsa -b 4096 -C "your@email.com"

    When you\'re prompted to \"Enter a file in which to save the key\", you can
    press **Enter** to accept the default file location.

        $ Enter a file in which to save the key (~/.ssh/id_ALGORITHM):[Press enter]

    Type a secure passphrase, if you want \-- this is an extra layer of
    security.

        $ Enter passphrase (empty for no passphrase): [Type a passphrase]
        $ Enter same passphrase again: [Type passphrase again]

    This will create a new SSH key, using the provided email as label.

Navigate to ssh key location \-- \".ssh\" folder at your homedir by default and
ensure there are two files generated:

-   **id_ALGORITHM** (e.g. \"id_rsa\", \"id_ed252519\" etc.)
-   **id_ALGORITHM.pub** (e.g. \"id_rsa.pub\", \"id_ed25519.pub\" etc.)

!!! important


    The private key (the one without \".pub\") should be kept secure and private.
    You should never share this.

    The public key is what you add to servers or services to which you want
    to authenticate using your private key.


### Adding your SSH key to the ssh-agent and GitHub

Before adding a new SSH key to the ssh-agent to manage your keys, you should
have checked for existing SSH keys and generated SSH keys.

1.  Ensure the ssh-agent is running. You can use the \"Auto-launching\" or
    start it manually:

        $ eval "$(ssh-agent -s)"
        > Agent pid 12345

2.  Add you SSH private key to the ssh-agent.

        ssh-add ~/.ssh/id_ALGORITHM

3.  Add the SSH public key to your account on GitHub.
    Copy the SSH public key to your clipboard.

        clip < ~/.ssh/id_ALGORITHM.pub

    Alternatively, if `clip` isn\'t working, just type public key content
    to the terminal using `cat`,

        cat ~/.ssh/id_ALGORITHM.pub

    or simply navigate to the file and open it with any text editor.
    At the end, you need to copy public key content.

4.  On GitHub, in the upper-right corner of any page, click your profile photo,
    then click **Settings**.

5.  In the \"Access\" section of the sidebar, click
    **SSH and GPG keys** and press **New SSH key** button.

6.  In the \"Title\" field, add a descriptive label for the new key.

7.  Select the type of key \-- \"Authentication key\".

8.  In the \"Key\" field, paste your public key.

9.  Click **Add SSH key**.

10. If prompted, confirm access to your account on GitHub.
