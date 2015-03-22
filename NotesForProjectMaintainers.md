#Some svn notes for maintainers

# Checking Out Code #

If you want to make changes, go right ahead and make them to trunk.  First check it out by following the [usual instructions](http://code.google.com/p/yaptestfe/source/checkout).

Then later commit your changes:

svn ci

# Tagging Code #

Periodically we'll tag trunk with a human-friendly name like 'release-1.1'.  Here's how I created this this tag:

svn copy https://yaptestfe.googlecode.com/svn/trunk/ https://yaptestfe.googlecode.com/svn/tags/release-1.1 -m 'Tagging the version 1.1 release from http://pentestmonkey.net/tools/yaptestfe/yaptestfe-1.1.tar.gz'

# Branches #

If you want to fork the code for a while to work on a major change you can do so like this (probably - I haven't actually tired it):

svn copy https://yaptestfe.googlecode.com/svn/trunk/ https://yaptestfe.googlecode.com/svn/branches/anyoldnameforyourbranch -m 'My new branch with lots of new kickass features'

This should help avoid having trunk broken for ages.

# Merging Branches Back Into Trunk #

We cross that bridge when we come to it. :-)