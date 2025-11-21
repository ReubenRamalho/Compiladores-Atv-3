  #
  # modelo de saida para o compilador
  #

  .section .text
  .globl _start

_start:
  ## EXPRESSAO 3:
  ## (42 - 222) * 11 + (19 * 88)

  # --- Parte 1: (42 - 222) * 11 ---
  mov $42, %rax
  mov $222, %rbx
  sub %rbx, %rax        # rax = 42 - 222 = -180

  mov $11, %rbx
  imul %rbx, %rax       # rax = -180 * 11 = -1980

  # --- Parte 2: 19 * 88 ---
  mov $19, %rcx
  mov $88, %rdx
  imul %rdx, %rcx       # rcx = 19 * 88 = 1672

  # --- Soma final ---
  add %rcx, %rax        # rax = -1980 + 1672 = -308


  call imprime_num
  call sair

  .include "runtime.s"
  
