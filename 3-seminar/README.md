# Семинар 03. Анализ и отладка программ на ассемблере

## Домашняя работа

Для выполнениия домашней работы был использован следующий материал

- [GDB Cheat Sheet](/GDB-Cheat-Sheet.pdf)
- [x86-64 Reference](/x86-64-reference.pdf)

---

## Разделы

### Анализ програм

- [01-immediate.s](#01-immediate.s)
- [02-register.s](#02-register.s)
- [03-memory.s](#03-memory.s)
- [04-constToMemory.s](#04-constToMemory.s)
- [05-jumps.s](#05-jumps.s)

### Сравнительная таблица инструментов для отладки ASM

- [Критерии](#Критерии)
- [Таблица](#Таблица)

---

### 01-immediate.s

Запись констант в различные регистры регистры и их sub-регистры.

```
        .intel_syntax noprefix
        .text
        .globl  main
        .type   main, @function
main:
        push    rbp         # save caller's frame pointer
        mov     rbp, rsp    # establish our frame pointer

        mov     al, 0xab    # 8-bit immediate
        mov     ax, 0xabcd  # 16-bit immediate
        mov     eax, 0xabcdef12  # 32-bit immediate
        mov     rax, 0xabcdef12  #    to 64-bit reg
        mov     rax, 0xabcdef0123456789  # 64-bit

        mov     eax, 0      # return 0 to os
        mov     rsp, rbp    # restore stack pointer
        pop     rbp         #   and frame pointer
        ret                 # back to caller
```

## ![](/3-seminar/screenshots/1.jpg)

### 02-register.s

Копирование значений регистров и sub-регистров между собой.

```
        .intel_syntax noprefix
        .text
        .globl  main
        .type   main, @function
main:
        push    rbp         # save caller's frame pointer
        mov     rbp, rsp    # establish our frame pointer

        mov     eax, ecx    # 32 bits, low reg codes
        mov     edi, esi    # highest reg codes
        mov     ax, cx      # 16 bits
        mov     al, cl      # 8 bits
        mov     eax, r8d    # 32 bits, 64-bit register
        mov     rax, rcx    # 64 bits

        mov     eax, 0      # return 0 to os
        mov     rsp, rbp    # restore stack pointer
        pop     rbp         #   and frame pointer
        ret                 # back to caller

```

## ![](/3-seminar/screenshots/2.jpg)

### 03-memory.s

Обращение к памяти используя различные способы задания смещения.

```
        .intel_syntax noprefix
        .text
        .globl  main
        .type   main, @function
main:
        push    rbp         # save caller's frame pointer
        mov     rbp, rsp    # establish our frame pointer
        sub     rsp, 48     # local variables

        mov     rcx, 5              # for indexing
        mov     eax, [rbp]          # indirect
        mov     eax, -48[rbp]       # indirect + offset
        mov     eax, -48[rbp+rcx]   # indirect + offset and index
        mov     eax, -48[rbp+4*rcx] #      and scaled index

        mov     eax, 0      # return 0 to os
        mov     rsp, rbp    # restore stack pointer
        pop     rbp         #   and frame pointer
        ret                 # back to caller
```

---

![](/3-seminar/screenshots/3-1.jpg)
![](/3-seminar/screenshots/3-2.jpg)

### 04-constToMemory.s

Запись констант в память. dword указывает на то, что мы хотим сохраниь ("размазать" по памяти) 32-битное значение.

```
        .intel_syntax noprefix
        .text
        .globl  main
        .type   main, @function
main:
        push    rbp         # save caller's frame pointer
        mov     rbp, rsp    # establish our frame pointer
        sub     rsp, 48     # local variables

        mov     rcx, 5              # for indexing
        mov     eax, [rbp]          # indirect
        mov     dword ptr -48[rbp], 0x12000034       # indirect + offset
        mov     dword ptr 48[rbp+rcx], 0x56000078   # indirect + offset and index
        mov     dword ptr -48[rbp+4*rcx], 0x91000023 #      and scaled index

        mov     eax, 0      # return 0 to os
        mov     rsp, rbp    # restore stack pointer
        pop     rbp         #   and frame pointer
        ret                 # back to caller
```

## ![](/3-seminar/screenshots/4.jpg)

### 05-jumps.s

Работа с условными переходами.

```
        .intel_syntax noprefix
        .text
        .globl  main
        .type   main, @function
main:
        push    rbp         # save caller's frame pointer
        mov     rbp, rsp    # establish our frame pointer

        xor     rax, rbx    # sets status flags
        jne     forward     # test ZF
back:
        mov     r8, r9      # stuff to jump over
        mov     rbx, rcx
forward:
        xor     rax, rbx    # sets status flags
        je      back        # test ZF

        mov     eax, 0      # return 0 to os
        mov     rsp, rbp    # restore stack pointer
        pop     rbp         # restore caller's frame pointer
        ret                 # back to caller

```

## ![](/3-seminar/screenshots/5.jpg)

## Сравнительная таблица инструментов для отладки ASM

## Критерии

В сравнении участвовали инструменты удовлетворяющие следующим условиям:

- Возможность запуска и дебага ASM кода
- Поддержка x86-64, GAS и нотации Intel

_Хочу отдельно выделить сервис goldbolt.org, который позволяет в реальном времени получать ASM код из кода написанного на C._
|Критерий |onlinegdb|CMD GDB|CMD GDB TUI|SASM|Вес оценки|
|----------------------------------------------------------|---------|-------|-----------|-|----------|
|Пользовательский интерфейс |8 |2 |5 |9|0,4 |
|Возможности символьной отладки на уровне исходных текстов|9 |9 |9 |9|0,7 |
|Отображение информации о регистрах |6 |5 |8 |6|0,7 |
|Простота использования |8 |3 |6 |10|0,5 |
|Наличие информации для изучения |7 |6 |6 |5|0,3 |
|Работа с кодом в рамках одного приложения |5 |0 |0 |6|0,5 |
|**Интегральная оценка** |**43** |**25** |**34** | **44**| |
|**Приведенная оценка** |**22,3** |**13,9** |**18,7** | **23,1**| |
