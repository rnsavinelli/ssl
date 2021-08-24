## Testing

### Makefile referece

Behaviour testing has been automated with the ``test`` tag inside the [Makefile](tp1/Makefile).

This is, to test the program behaviour with the contents of [entrada.txt](tp1/entrada.txt) run:

```
$ make test
```

this is the short form of the following script:

```
$ gcc -std=c17 -Wall -pedantic-errors ./*.c -o tp1.out && valgrind -q --tool=memcheck --leak-check=full ./tp1.out <entrada.txt
```

### Expected output

```
$ make test
gcc -std=c17 -Wall -pedantic-errors ./*.c -o tp1.out && valgrind -q --tool=memcheck --leak-check=full ./tp1.out <entrada.txt
Cadena: uno
Separador: ,
Cadena: dos
Separador: ,
Separador: ,
Cadena: 785
Cadena: +*@#$a3
Cadena: ultimo
Fin de texto: �
```

## About

- The standard c17 has been adopted as a requisite.
- Valgrind is used to check for memory leaks.
- Upon `EOF` the symbol � is printed because there is no character whose code is referenced as `-1`.
