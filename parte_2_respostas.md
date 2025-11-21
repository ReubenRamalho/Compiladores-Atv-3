# Parte 2 — Respostas

Nesta seção respondemos as três perguntas teóricas sobre a tradução de expressões aritméticas para assembly x86-64.

---

## **1. Qual o menor número de registradores necessários para calcular a expressão:**

\[
a_1 + a_2 + ... + a_n
\]

(sendo todos os \( a_i \) inteiros constantes)

### ✔️ **Resposta: 1 registrador**

Como todos os valores são constantes, basta carregar o primeiro termo em `RAX` e ir somando as constantes diretamente:

```asm
mov $a1, %rax
add $a2, %rax
add $a3, %rax
...
````

Nenhum outro registrador é necessário.

---

## **2. Qual o menor número de registradores necessários para calcular:**

[
(a_{11} * a_{12} * ... * a_{1n}) + ... + (a_{m1} * a_{m2} * ... * a_{mn})
]

(sendo todos os ( a_{ij} ) inteiros constantes)

### ✔️ **Resposta: 2 registradores**

### 🔍 Por quê?

A multiplicação **não exige** necessariamente dois registradores:
é possível calcular qualquer produto usando **apenas um**, multiplicando `RAX` por constantes imediatas:

```asm
mov $a, %rax
imul $b, %rax
imul $c, %rax
...
```

Ou seja:
✔️ **Um produto isolado pode ser calculado só com 1 registrador.**

---

### ⭐ ENTÃO POR QUE O MÍNIMO TOTAL É 2 REGISTRADORES?

Porque a expressão da questão envolve **somar vários produtos diferentes**.

Para fazer isso, precisamos:

1. Calcular um produto inteiro usando **um único registrador auxiliar**, por exemplo `RBX`:

   ```asm
   mov $a, %rbx
   imul $b, %rbx
   imul $c, %rbx
   ```

2. Somar esse produto ao **acumulado final**, que precisa permanecer em `RAX`:

   ```asm
   add %rbx, %rax
   ```

3. Depois, calcular o próximo produto novamente em `RBX` sem mexer no `RAX`:

   ```asm
   mov $d, %rbx
   imul $e, %rbx
   imul $f, %rbx
   add %rbx, %rax
   ```

E assim sucessivamente.

---

### 🧠 O raciocínio completo:

* O acumulado final precisa estar sempre em **RAX**.
* Para calcular cada novo produto sem destruir o acumulado, precisamos de **um registrador auxiliar** (RBX).
* RBX calcula cada produto individual usando imediatos.
* Depois somamos RBX em RAX.
* Repetimos esse processo para todos os produtos.

➡️ **Isso exige exatamente dois registradores:**

* **RAX** → acumulador da soma final
* **RBX** → calculador temporário de cada produto

---

### 🎯 Conclusão da Questão 2

> Mesmo que cada produto isolado possa ser calculado com apenas 1 registrador, a expressão completa exige somar vários produtos diferentes.
> Para preservar o valor acumulado e ainda calcular o próximo produto, o mínimo necessário é **2 registradores**: um acumulador (`RAX`) e um registrador auxiliar (`RBX`) para montar cada produto antes de somar.

Portanto, a resposta correta é:

# **2 registradores**