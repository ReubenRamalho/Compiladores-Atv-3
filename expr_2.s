  #
  # modelo de saida para o compilador
  #

  .section .text
  .globl _start

_start:
  ## EXPRESSAO 2:
  ## (9 * 8 * 7) / (6 * 5 * 4 * 3 * 2)

  # --- Numerador: 9 * 8 * 7 ---
  mov $9, %rax       # rax = 9
  mov $8, %rbx       # rbx = 8
  imul %rbx, %rax    # rax = 9 * 8 = 72

  mov $7, %rbx
  imul %rbx, %rax    # rax = 72 * 7 = 504

  # --- Denominador: 6 * 5 * 4 * 3 * 2 ---
  mov $6, %rcx       # rcx = 6
  mov $5, %rdx
  imul %rdx, %rcx    # rcx = 6 * 5 = 30

  mov $4, %rdx
  imul %rdx, %rcx    # rcx = 30 * 4 = 120

  mov $3, %rdx
  imul %rdx, %rcx    # rcx = 120 * 3 = 360

  mov $2, %rdx
  imul %rdx, %rcx    # rcx = 360 * 2 = 720

  # --- Divisão inteira: rax / rcx ---
  cqo                # estende rax -> rdx:rax
  idiv %rcx          # rax = 504 / 720 = 0


  call imprime_num
  call sair

  .include "runtime.s"
  
