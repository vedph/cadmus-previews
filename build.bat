@echo off
set xu=\Projects\Xml\Xutil\bin\Debug\net10.0\Xutil.exe

echo APPARATUS FRAGMENT
set docdir=\Projects\Cadmus\cadmus-previews\fr.it.vedph.apparatus\
%xu% transform %docdir%fr.xml %docdir% %docdir%fr.xsl -f html
pause

echo CHRONOLOGY FRAGMENT
set docdir=\Projects\Cadmus\cadmus-previews\fr.it.vedph.chronology\
%xu% transform %docdir%fr.xml %docdir% %docdir%fr.xsl -f html
pause

echo COMMENT FRAGMENT
set docdir=\Projects\Cadmus\cadmus-previews\fr.it.vedph.comment\
%xu% transform %docdir%fr.xml %docdir% %docdir%fr.xsl -f html
pause

echo NOTE PART
set docdir=\Projects\Cadmus\cadmus-previews\it.vedph.note\
%xu% transform %docdir%part.xml %docdir% %docdir%part.xsl -f html
pause
