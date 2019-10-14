#!/usr/bin/env perl
##============================================================================##
## file         .latexmkrc
## author       Ryotaro Onuki (GitHub: kerikun11)
## created_at   2019.01.25
## modified_at  2019.07.05
##============================================================================##
## latex commands; %S: src, %O: option, %D: dest, %B: src without extension
$latex      = 'platex -synctex=1 -halt-on-error -interaction=batchmode %O %S';
$bibtex     = 'pbibtex -kanji=utf8 %O %B';
$biber      = 'biber --bblencoding=utf8 -u -U --output_safechars';
$pdflatex   = 'lualatex --synctex=1 --halt-on-error --interaction=batchmode %O %S';
$dvipdf     = 'dvipdfmx %O -o %D %S';
$makeindex  = 'mendex %O -o %D %S';
$max_repeat = 4;
$bibtex_use = 2;
##============================================================================##
## pdf mode
$pdf_mode   = 3; # 0: none, 1: pdflatex, 2: ps2pdf, 3: dvipdf
##============================================================================##
## output directory
$aux_dir    = "build/";
$out_dir    = "build/";
##============================================================================##
## viewer settings
$pvc_view_file_via_temporary = 0;
if ($^O eq 'darwin') {
    # OSX
    $pdf_previewer = 'open -a Preview';
} elsif ($^O eq 'linux') {
    # linux
    $pdf_previewer = 'evince';
} else {
    # Windows
    $pdf_previewer    = '"C:\Program Files\SumatraPDF\SumatraPDF.exe" -reuse-instance %O %S';
}
##============================================================================##
