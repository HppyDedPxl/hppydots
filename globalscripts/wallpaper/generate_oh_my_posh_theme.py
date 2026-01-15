import sys


theme_path = sys.argv[1]
palette_path = sys.argv[2]
out_path = sys.argv[3]

theme = ""
palette = ""
final = ""
with open(theme_path,'r') as file:
    theme = file.read()

with open(palette_path,'r') as file:
    palette = file.read()

final = theme.replace("{palette}",palette)

with open(out_path,'w') as file:
    file.write(final)

