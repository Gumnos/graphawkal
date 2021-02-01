# graphawkal

Counts things and graphs them.  Requires a `mark` (defaults to a blank line) to let it know a set of output is done.

To only graph once, such as to find files by extension:

    $ (find . -type f -name "?*.*" ; echo) | awk -F'[.]' -f graph.awk
    $ (find . -type f -name "?*.*" ; echo) | graph.awk -F'[.]'
    
To monitor output, you can use something like
    
    $ (while : ; do find . -type f -name "?*.*" ; echo; sleep 5; done) | awk -F'[.]' -f graph.awk
    $ (while : ; do find . -type f -name "?*.*" ; echo; sleep 5; done) | graph.awk -F'[.]'

It graphs based on the last "field" on each input line, so you can change the field-delimiter using the `-F` option for `awk`.
