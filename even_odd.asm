section .data
    ask     db "Son kiriting: "
    askLen  equ $ - ask

    evenMsg db "Natija: Juft son", 10
    evenLen equ $ - evenMsg

    oddMsg  db "Natija: Toq son", 10
    oddLen  equ $ - oddMsg

section .bss
    input resb 4

section .text
    global _start

_start:
    ; write "Son kiriting: "
    mov rax, 1
    mov rdi, 1
    mov rsi, ask
    mov rdx, askLen
    syscall

    ; read input
    mov rax, 0
    mov rdi, 0
    mov rsi, input
    mov rdx, 4
    syscall

    ; ASCII -> integer
    mov al, [input]
    sub al, '0'        ; '5' -> 5
    mov bl, 2
    xor ah, ah
    div bl             ; al / 2

    ; ah = qoldiq
    cmp ah, 0
    je EVEN

ODD:
    mov rax, 1
    mov rdi, 1
    mov rsi, oddMsg
    mov rdx, oddLen
    syscall
    jmp EXIT

EVEN:
    mov rax, 1
    mov rdi, 1
    mov rsi, evenMsg
    mov rdx, evenLen
    syscall

EXIT:
    mov rax, 60
    xor rdi, rdi
    syscall
