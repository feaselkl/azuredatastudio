#!/bin/bash

# Runs unit tests for Extensions
set -e

if [[ "$OSTYPE" == "darwin"* ]]; then
	realpath() { [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"; }
	ROOT=$(dirname $(dirname $(realpath "$0")))
	VSCODEUSERDATADIR=`mktemp -d -t 'myuserdatadir'`
	VSCODEEXTDIR=`mktemp -d -t 'myextdir'`
else
	ROOT=$(dirname $(dirname $(readlink -f $0)))
	VSCODEUSERDATADIR=`mktemp -d 2>/dev/null`
	VSCODEEXTDIR=`mktemp -d 2>/dev/null`
fi

cd $ROOT
echo $VSCODEUSERDATADIR
echo $VSCODEEXTDIR

./scripts/code.sh --extensionDevelopmentPath=$ROOT/extensions/notebook --extensionTestsPath=$ROOT/extensions/notebook/out/test --user-data-dir=$VSCODEUSERDATADIR --extensions-dir=$VSCODEEXTDIR

rm -r $VSCODEUSERDATADIR
rm -r $VSCODEEXTDIR
