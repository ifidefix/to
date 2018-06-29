# To
Change directory to any of your favorite folders with a single short command, wherever your are.

# Usage
see SPEC.md, the man page or run

    to -h

A short description is provided here:

    cd ~/workspace # Directory containing your often accessed folder 'project'
    to -a # Adds the current directory to your favorites
    
    cd  ~/somewhere/else/entirely
    # Changes the current directory to ~/workspace/project
    to project
    # Or type:
    to proj
    # Then press TAB to autocomplete, or press enter for an "I'm feeling lucky"
    
    # List all favorite folders
    to -l
    # output:
    # [0]   /home/you/workspace
    
    # Remove the favorite at index 0
    to -r 0

# Installing the manpage
First, check where the manpages are stored:

    manpath

By default, this should include /usr/local/share/man. This is the common place to install man pages for custom commands. It is possible to save them directly in /usr/share/man and while this would work,  it is not the way to go. This is reserved for the package manager and conflicts could arise.

If it does not exist yet, create a directory for custom command man pages

    sudo mkdir /usr/local/share/man/man1
Copy the manpage to the newly created directory.

    sudo cp to.1 /usr/local/share/man/man1/
Update the manpages database

    sudo mandb
Now the manpage should be visible

    man to