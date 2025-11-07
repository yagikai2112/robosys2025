#!/bin/bash
　 
ng () {
	echo ${1}行目が違うよ
	res=1
}

res=0
a=栁内
[ "$a" = 柳内 ] || ng "$LINENO"
[ "$a" = 栁内 ] || ng "$LINENO"

exit $res
