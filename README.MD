# Atividade 03 — Expressões Aritméticas em Assembly

## Integrantes

- **LUIZ MANOEL BARBOSA RAMALHO** — 20220096614  
- **REUBEN LISBOA RAMALHO CLAUDINO** — 20210024602  
- **VICTOR PESSOA OLIVEIRA ORTINS** — 20210024667  

---

## Como rodar:

Cada expressão foi implementada em um arquivo separado (`expr_1.s`, `expr_2.s`, `expr_3.s`), seguindo o modelo fornecido pelo professor.

Para compilar e executar qualquer uma das expressões, utilize os comandos abaixo:

### 1. Monte o arquivo da expressão:

```bash
as -o expr_x.o expr_x.s
````

(Substitua `x` por 1, 2 ou 3.)

### 2. Monte o arquivo do runtime:

```bash
as -o runtime.o runtime.s
```

### 3. Faça o link para gerar o executável:

```bash
ld -o programa expr_x.o runtime.o
```

### 4. Execute:

```bash
./programa
```

O programa exibirá no terminal o resultado calculado da expressão aritmética.
