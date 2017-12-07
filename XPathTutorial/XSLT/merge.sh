#!/bin/sh

mkdir ../jjtmp

for (( i = 1; i <= 22; i++ )); 
 do
  saxonclient -o ../jjtmp/source$i.xml ../SourceXML/source$i.xml merge.xslt i=$i
done;