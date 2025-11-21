  #
  # modelo de saida para o compilador
  #

  .section .text
  .globl _start

_start:
  ## EXPRESSAO 1:
  ## (19 * 15 - 10 * 7) + (117 - 33)

  mov $19, %rax       # rax = 19
  mov $15, %rbx       # rbx = 15
  imul %rbx, %rax     # rax = 19 * 15 = 285

  mov $10, %rcx       # rcx = 10
  mov $7,  %rdx       # rdx = 7
  imul %rdx, %rcx     # rcx = 10 * 7 = 70

  sub %rcx, %rax      # rax = 285 - 70 = 215

  mov $117, %rbx      # rbx = 117
  mov $33,  %rcx      # rcx = 33
  sub %rcx, %rbx      # rbx = 84

  add %rbx, %rax      # rax = 215 + 84 = 299


  call imprime_num
  call sair

  .include "runtime.s"
  
