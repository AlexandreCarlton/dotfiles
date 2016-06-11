# Ccache

Ccache is a neat utility to store compiler results for subsequent compilations.
We point our symlinks at hard-coded paths because we appear unable to point to
relative ones (which would be be nice to allow using ccache from non-default
locations). This may require further investigation, however.

By calling `ccache --set-config=prefix_command=distcc` we can also use `distcc`
in tandem with `ccache`, farming out our work to other servers.
