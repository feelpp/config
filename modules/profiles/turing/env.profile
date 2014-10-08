#%Module1.0################ -*- mode: tcl -*-
## 
## feelpp profile - virtual module
#
# Load all necessary modules for
# compiling the feel++ library with
# the bgclang compiler

if [module-info mode load]  {
    module load cmake/2.8.9
    module load tools/git.feelpp
    module load editors/emacs-24.3.feelpp
}

if [module-info mode remove] {
    module unload tools/git.feelpp
    module unload editors/emacs-24.3.feelpp
    module unload cmake/2.8.9
}
