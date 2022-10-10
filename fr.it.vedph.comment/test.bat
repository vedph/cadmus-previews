@echo off
set docdir=\Projects\Cadmus\cadmus-previews\fr.it.vedph.comment\
set xu=\Projects\Xml\Xutil\bin\Release\net6.0\Xutil.exe
%xu% transform %docdir%sample.xml %docdir% %docdir%go.xsl -f html
pause
