Right now everything lives inside of recipes_c-ansi since this is the only way I found of getting the shit to compile correctly. To compile it you need to run this line:

gcc gen_efield.c -o gen_efield -I./include -I./recipes -L./lib -lrecipes_c -lm

This should work to compile it correctly in the same file. I don't really know how to make this less stupid, but the fact that it compiles at all is courtesy of Daniel Abadjiev.