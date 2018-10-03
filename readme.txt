Symlinking
relative path
ln -sf repositories/config-files/.vimrc ~/.vimrc

absolute
ln -sf ~/repositories/config-files/.vimrc ~/.vimrc 

automatically converted to relative
ln -rsf ~/repositories/config-files/.vimrc ~/.vimrc 

Setup symlinks to
~/.vim
~/.vimrc

ln -sf ~/Dev/vimStuff/config-files/.vim ~/.vim 
ln -sf ~/Dev/vimStuff/config-files/.vimrc ~/.vimrc 
