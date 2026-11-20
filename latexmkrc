# Shared build configuration for CLI, PowerShell, VS Code and CI.
# Run from the project root: latexmk -norc -r latexmkrc main.tex
$pdf_mode = 5;  # XeLaTeX -> XDV -> PDF
$out_dir = 'build';
$aux_dir = 'build';
$jobname = 'Zorich_Analysis_Book1';
$xelatex = 'xelatex -no-shell-escape -synctex=1 -interaction=nonstopmode -halt-on-error -file-line-error %O %S';
$max_repeat = 5;
@default_files = ('main.tex');
