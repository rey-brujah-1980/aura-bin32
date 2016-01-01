#!/usr/bin/env fish

## Set variables to use
set ROOT (pwd)
set BUILD $ROOT/../build
set COMPILED $ROOT/../compiled
set SCRIPTS $ROOT
set OLD_VERSION aura-1.3.4-i686.tar.gz
set NEW_VERSION aura-1.4-i686.tar.gz

function build
	## Test if build and tmp archive diretory exists
	if test ! -d $BUILD/archive
		mkdir -p $BUILD/archive
	end

	## Change directory to tmp archive directory
	cd $BUILD/archive

	## Test if source tarbar exists
	if test -f $COMPILED/$OLD_VERSION

		## Uncompress 
		tar -zxf $COMPILED/$OLD_VERSION -C $BUILD/archive/

	else 

		## Exits if source tarball cannot be found
		echo "Cannot find source tarbar... failed build!"
		exit 1
	end

	## Tests if aura git is already cloned
	if test ! -d $BUILD/aura-git

		## Clones aura git repo
		git clone http://github.com/aurapm/aura/ $BUILD/aura-git
	end

	## Change directory into git repo
	cd $BUILD/aura-git

	## Checks to see if we have the right branch checked out
	if [ (git branch | grep -e '\*' | cut -d ' ' -f 2) != aura-$VERSION ]

		## Checks out the proper git branch
		git checkout aura-$VERSION
	end	

	## Test if aura was already build
	if test ! -f $BUILD/aura

		## Builds aura
		stack build 

		## Install aura to temp archive directory
		stack install --local-bin-path $BUILD/archive
	end

	tar -zcf $COMPILED/$NEW_VERSION $BUILD/archive
	
	if test $status -eq 0
		clean
	end if
end

## Cleans up directory from build
function clean
	if test -d $BUILD
		rm -rf $BUILD
	end
	
	if test -f $COMPLIED/$OLD_VERSION
		rm -f $COMPLIED/$OLD_VERSION
	end
end

## Commandline args
switch (echo $argv)
	case clean
		clean
	case '*'
		build
end