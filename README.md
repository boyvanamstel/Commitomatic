# Overview

Commitomatic is an experiment. It watches your git repos for changes and reports them. Waiting for you to hook in some action. Ofcourse you could use git's own hooks, but that requires you to set it up per project.

Code isn't optimized, or pretty for that matter :).

# Requirements

Install Grit:

	$ sudo gem install grit

FSSM might tell you to install additional platform specific gems.

# Running it

Simple append the path to your repos and watch.

	$ ruby ./watch /home/git/repositores

