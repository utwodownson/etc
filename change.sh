#!/bin/sh

if [ $# -ne 1 ] ; then
    echo "machine list:"
    awk '{print $1"\t"$2"\t"$4}' ~/.passwd
    exit
fi

EXPECT_SH=~/.expect

ret=$?
if [ $ret -eq 2 ] ; then
    echo "~/.passwd not exists"
    exit
elif [ $ret -ne 0 ] ; then
    echo "error name $1"
    echo "machine list:"
    echo "short	machine	label"
    awk '{print $1"\t"$2"\t"$4}' ~/.passwd
    exit
fi

line=`grep "^$1\>" ~/.passwd`
key=`echo $line|awk '{print $1}'`
host=`echo $line|awk '{print $2}'`
pswd=`echo $line|awk '{print $3}'`
title=`echo $line|awk '{print $4}'`

echo -ne "\e]2;$title\a"
echo "#!/home/tools/bin/64/expect -f" > $EXPECT_SH
echo "spawn ssh $host" >> $EXPECT_SH
echo expect \"*password:\" {send \"$pswd\\r\"} >> $EXPECT_SH
echo interact >> $EXPECT_SH

chmod 755 $EXPECT_SH
$EXPECT_SH
