#!/usr/bin/env fish

## Set variables to use
set ROOT (pwd)
set BUILD $ROOT/../build
set COMPILED $ROOT/../compiled
set SCRIPTS $ROOT
set OLD_VERSION aura-1.3.4-i686.tar.gz
set NEW_VERSION aura-1.4-i686.tar.gz

function build
	msg1 "STEP 1: Create tmp archive directory"
	## Test if build and tmp archive diretory exists
	if test ! -d $BUILD/archive
		mkdir -p $BUILD/archive
	end
	
	msg2
	
	## Change directory to tmp archive directory
	cd $BUILD/archive

	msg1 "STEP 2: Uncompressed old source tarball"
	## Test if source tarball exists
	if test -f $COMPILED/$OLD_VERSION

		## Uncompress 
		tar -zxf $COMPILED/$OLD_VERSION -C $BUILD/archive/ > /dev/null
		msg2
	else 
	

		## Exits if source tarball cannot be found
		echo "Cannot find source tarbar... failed build!"
		exit 1
	end
	
	msg1 "STEP 3: Cloning git repo"
	## Tests if aura git is already cloned
	if test ! -d $BUILD/aura-git

		## Clones aura git repo
		git clone http://github.com/aurapm/aura/ $BUILD/aura-git --quiet
	end
	msg2

	## Change directory into git repo
	cd $BUILD/aura-git

	msg1 "STEP 4: Switch to $VERSION branch"
	## Checks to see if we have the right branch checked out
	if test (git branch | grep -e '\*' | cut -d ' ' -f 2 ) != "aura-$VERSION"

		## Checks out the proper git branch
		git checkout aura-$VERSION --quiet
	end	
	msg2
	
	msg1 "STEP 5: Build aura using stack"
	## Test if aura was already build
	if test ! -f $BUILD/aura

		## Builds aura
		stack build > /dev/null ^ /dev/null

		## Install aura to temp archive directory
		stack install --local-bin-path $BUILD/archive > /dev/null ^ /dev/null
	end
	msg2
	
	msg1 "STEP 6: Building new tarball"
	tar -zcf $COMPILED/$NEW_VERSION $BUILD/archive > /dev/null ^ /dev/null
	msg2
	
	if test $status -eq 0
		clean
	end if
end

## Cleans up directory from build
function clean
	msg1 "Starting clean"
	if test -d $BUILD
		rm -rf $BUILD
	end
	
	if test -f $COMPLIED/$OLD_VERSION
		rm -f $COMPLIED/$OLD_VERSION
	end
	msg2
end

function msg1
	echo -en "----[ $argv ]----"
end

function msg2
	echo -e "done."
end


## Commandline args
switch (echo $argv)
	case clean
		clean
	case '*'
		build
end