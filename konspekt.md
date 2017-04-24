# Konspekt laboratorium - binutils + biblioteki statyczne/dynamiczne

![elf](https://s-media-cache-ak0.pinimg.com/originals/30/ce/f7/30cef77d888aeb4709c7bd97d08fe460.png)

## 1\. Cel laboratorium

Laboratorium ma na celu zapoznanie studentów z możliwościami użycia narzędzi z pakietu `binutils` oraz podstawami budowy plików wykonywalnych w formacie ELF.

## 2\. Cheatsheet

### Charakterystyka narzędzi

| Nazwa narzędzia | Używane do                                                                              |
|:----------------|:----------------------------------------------------------------------------------------|
| as              | asemblacja języka asemblera                                                             |
| ld              | linkowanie plików obiektowych i bibliotek, relokacja i rozwiązywanie symboli            |
| ar              | tworzenie, modyfikowanie i rozpakowywanie archiwów bibliotek statycznych                |
| nm              | listowanie symboli zawartych w plikach obiektowych                                      |
| objcopy         | kopiowanie i tłumaczenie plików obiektowych                                             |
| objdump         | wyświetlanie informacji z plików obiektowych                                            |
| size            | listowanie rozmiarów sekcji i całkowitego rozmiaru plików wykonywalnych                 |
| strings         | listowanie wszystkich możliwych do wypisania stringów zawartych w plikach wykonywalnych |
| strip           | wycinanie symboli z plików wykonwalnych                                                 |
| c++filt         | demanglowanie symboli c++ lub java                                                      |
| addr2line       | konwertowanie adresów do nazw plików i numerów linii w ich obręcie                      |
| readelf         | wyświetlanie informacji o plikach w formacie ELF                                        |

Każde z narzędzi posiada dużą liczbę możliwych parametrów, dlatego nie będziemy ich opisywać w tym dokumencie. W celu dowiedzenia się więcej na temat każdego z nich: `man nazwa-narzedzia`.

### Informacje na temat budowy ELF

Definicje struktur opisujących pliki ELF w linuxie: <https://github.com/torvalds/linux/blob/master/include/uapi/linux/elf.h>

Najważniejsze z naszego punktu widzenia:

1. Nagłówek pliku ELF `Elf64_Ehdr`
2. Nagłówek programu `Elf64_Phdr`
3. Nagłówek sekcji `Elf64_Shdr`

Pełna specyfikacja ELF, w której możemy znaleźć znaczenie poszczególnych pól w strukturach: <http://www.skyfree.org/linux/references/ELF_Format.pdf>

## 2\. Zadania

### Zadanie 1.

1. Przy pomocy `as` zasembluj pliki źródłowe `main.s`, `func1.s` oraz `func2.s` do plików obiektowych.

2. Przy pomocy narzędzia `file` zbadaj typy utworzonych przez asembler plików.

3. Zlinkuj pliki obiektowe przy pomocy `ld`. Postaraj się, aby ostateczny plik wykonywalny zajmował jak najmniej przestrzeni dyskowej. (_tip: nie potrzebujemy informacji o symbolach_).

4. Porównaj wielkość pliku wykonywalnego przed i po zagiegu _uszczuplania_ oraz sprawdź przy pomocy `objdump` lub `readelf`, które sekcje udało się zmniejszyć.

### Zadanie 2.

1. Napisz w języku C program, który będzie wypisywał na ekran wyniki wywołań 2 funkcji, zaimplementowanych w dwóch osobnych plikach.
  ```c
  int add(int a, int b);
  int multiply(int a, int b);
  ```
2. Skompiluj pliki z funkcjami do plików obiektowych i przy pomocy narzędzia `ar` utwórz z nich bibliotekę statyczną `libmymath.a`.

3. Skompiluj plik `main.c` z zaimplementowaną funkcją `main` do pliku obiektowego i sprawdź na jakie adresy wskazują wywołania funkcji z biblioteki.

4. Linkując `main.o` z `my_math.a` utwórz plik wykonywalny i ponownie sprawdź
adresy wywołań funkcji z biblioteki.

5. Zbadaj obecność nagłówka programu oraz nagłówka sekcji w finalnym pliku wykonywalnym oraz plikach obiektowych biblioteki. Wykorzystaj do tego `readelf`. _Czy nagłówek sekcji musi występować w pliku wykonywalnym?_

### Zadanie 3.
1. Przy pomocy `ar` sprawdź zawartość biblioteki `/usr/lib/liblapack.a`.

2. Utwórz _odchudzoną_ wersję biblioteki `liblapack.a` - `liblapack_min.a`, zawierającą tylko 2 wybrane pliki obiektowe.

3. Przy pomocy `nm` sprawdź symbole, jakie udostępnia zmniejszona wersja biblioteki. Zwróć uwagę na wyświetlony indeks archiwum.

4. Dodaj do utworzonej już biblioteki nowy plik obiektowy.

### Zadanie 4.
Bez dopisywania żadnego kodu, skompiluj plik `main.c` do działającego pliku wykonywalnego. (*tip: widoczność symboli*).

### Zadanie 5.
1. Napisz własną wersję funkcji `open`, która poza wywołaniem oryginalnej funkcji, będzie wypisywać na standardowe wyjście nazwę otwieranego pliku. Aby możliwe było wywołanie funkcji o tej samej nazwie, konieczne będzie skorzystanie z dynamicznego linkera (nagłówek `<dlfcn.h>`).

2. Zbuduj bibliotekę dynamiczną z nową wersją funkcji. Pamiętaj o odpowiednich flagach kompilacji: `-fPIC` i `-shared`.

3. Przy pomocy zmiennej środowiskowej `LD_PRELOAD` dokonaj podmiany oryginalnej funkcji i sprawdź działanie programu, korzystającego z podmienianej funkcji, np. `vim`.

Alternatywna wersja zadania: implementacja `printf`, konwertującego wszystkie wypisywane stringi do "l33ta".

### Zadanie 6.
1. Sprawdź przy pomocy `ldd`, jakich bibliotek dynamicznych wymaga plik wykonywalny `main`.

2. Przy pomocy `nm` znajdź niezdefiniowane symbole.

3. Zdeasembluj `main` i przyjrzyj się trzem porównaniom występującym w funkcji `main`.

4. Zaimplementuj niezdefiniowane funkcje w postaci biblioteki dynamicznej o odpowiedniej nazwie oraz postaraj się, aby zwracały one odpowiednie wartości (wywnioskowane na podstawie porównań w funkcji `main`) -- tylko w ten sposób program będzie mógł poinformować o Twojej wygranej .

5. Przy pomocy zmiennej środowiskowej `LD_LIBRARY_PATH` spraw, aby linker mógł odnaleźć stworzoną bibliotekę.

### Zadanie 7.
1. Napisz program, który z wykorzystaniem dynamicznego linkera, w trakcie wykonywania pozwoli użytkownikowi wybrać, którą wtyczkę załaduje.

2. Zaimplementuj dwie biblioteki dynamiczne, które będą wtyczkami dla programu. Można ograniczyć się do implementacji jednej funkcji o tym samym prototypie, np. `void init_plugin()`, wypisującej coś na ekran.

3. Wtyczki umieść w katalogu `./plugins/`. Zadbaj o to, aby wtyczki były widoczne dla linkera przez użycie `rpath` lub `runpath` w pliku wykonywalnym. Dowiedz się, która z dwóch opcji jest bardziej preferowana i dlaczego.

### Zadanie 8.
1. Z wykorzystaniem definicji struktury nagłówka pliku ELF, napisz program, który wypisze na ekran typ pliku wykonywalnego.

2. Zadbaj o sprawdzenie, czy plik jest typu ELF. (*magic bytes*)

3. \* Możesz rozszerzyć program o wypisywanie pozostałych pól nagłówka (na wzór `readelf -h`)

### Zadanie 9.
1. Napisz i skompiluj dowolny program w C++, zawierający 3 przeciążenia jednej funkcji.

2. Sprawdź, jak wyglądają ich nazwy w tablicy symboli.

3. Przy pomocy `c++filt` dokonaj demanglacji nazw funkcji.

### Zadanie 10.
Przy pomocy narzędzia `ldconfig` sprawdź, jakie biblioteki są widoczne dla linkera.

### Zadanie 11.
Zapoznaj się ze sposobem debugowania linkowania/ładowania przy pomocy zmiennej środowiskowej `LD_DEBUG`.

```bash
LD_DEBUG=help ls
```

1. Sprawdź w jakiej kolejności wyszukiwane są biblioteki dynamiczne przez linker dla dowolnego programu, np. `vim`.
