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

### **2 registradores**
---

## **3. Existe alguma forma de calcular expressões aritméticas constantes de tamanho arbitrário com um número limitado de registradores?**

### ✔️ **Resposta curta: Não. Para uma expressão totalmente genérica, não é possível.**

---

### 🔍 **Explicação detalhada**

Podemos representar qualquer expressão aritmética formada por constantes e operadores básicos ((+, -, \times, /)) como uma **árvore binária de expressão**, onde:

* Os **nós internos** são operadores.
* As **folhas** são constantes.
* Cada expressão tem a forma:

```text
(ExprA) Operador (ExprB)
```

Para calcular uma expressão desse tipo, precisamos:

* **R1** para armazenar o resultado de `ExprA`.
* **R2** para armazenar o resultado de `ExprB`.

---

### 🌳 **Mas o problema é que a expressão é recursiva**

`ExprB` também pode ser uma expressão composta:

```text
ExprB = (ExprC) Operador (ExprD)
```

Isso significa que, para calcular `ExprB`, precisamos:

* **R2** para guardar o resultado de `ExprC`.
* **R3** para guardar o resultado de `ExprD`.

E assim por diante.

Como uma expressão pode se expandir recursivamente para qualquer tamanho, não existe limite superior fixo para a profundidade dessa árvore.

➡️ **Logo, o número de registradores necessários cresce com a profundidade da árvore.**

---

### ❗ Pior caso (árvore totalmente desbalanceada)

Se uma expressão é construída de modo que cada subexpressão dependa da próxima (tipo uma cadeia profundamente aninhada):

```text
(((a + b) + c) + d) + e
```

a profundidade cresce linearmente → **mais registradores são necessários conforme o tamanho aumenta**.

---

### ⭐ “Melhor caso” (árvore balanceada)

Uma árvore perfeita, completamente simétrica, reduz a profundidade, mas **ainda aumenta conforme o tamanho cresce**.

Mesmo sendo mais eficiente, ela **não elimina o problema fundamental**:
quanto maior a árvore, maior o número de registradores necessários para avaliá-la sem sobrescrever valores intermediários.

---

### 🎯 **Conclusão da Questão 3**

> Para expressões aritméticas **constantes, arbitrárias e recursivas**, o número de registradores necessários depende da **profundidade da árvore de expressão**.
> Como essa profundidade pode crescer indefinidamente, **não existe um número finito de registradores capaz de avaliar todas as expressões possíveis**.

Portanto:

### **❌ Não é possível calcular expressões aritméticas constantes arbitrárias com um número limitado de registradores.**
