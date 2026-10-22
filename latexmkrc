# LuaLaTeX only (both Japanese and English modes)
$pdf_mode = 4;
$lualatex = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
# upbibtex reads UTF-8 Japanese entries
$bibtex = 'upbibtex %O %B';
$out_dir = 'build';
