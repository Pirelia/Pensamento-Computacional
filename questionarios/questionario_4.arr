use context starter2024


# QUESTÃO 2

#|
    Funções de Alta-Ordem não nessáriamente são funções recursivas

    Funções de Alta-Ordem:
        São funções que recebem funções como argumentos e Retornam funções
    Funções recursivas:
        São funções que chama a si próprio durante uma execução

    |Característica:	                |Alta ordem:	    |Recursiva:

    |Recebe ou retorna funções	        |Sim, por definição	|Não necessariamente
    |Chama a si própria	                |Não necessariamente|Sim
    |Pode existir sem o outro conceito?	|Sim	            |Sim

    Alta ordem: função trabalhando com outras funções.
    Recursão: função chamando a si mesma.
|#

 
# Funções de Alta-Ordem:
#   São funções que recebem funções como argumentos e Retornam funções

# Exemplo
fun aplicar(f, x):
  f(x)
end

fun dobro(x):
  x * 2
end

aplicar(dobro, 5)


# Funções recursivas:
#   São funções que chama a si próprio durante uma execução

# Exemplo

fun tamanho(lista):
    cases(list) l:
        | empty => empty
        | tamanho(f, r) => 1 + tamanho(resto)

# O fato de g ser uma função de alta ordem não garante que a aplicação g(f) será executada sem erros. 
# O comportamento depende da implementação de g e do que ela faz com a função recebida.
# Por exemplo:
fun g(f):
  f(10)
end

fun f(x):
  x + 1
end

g(f) # 11

# Mas nessa questão nós estamos garantindo que o f(x) foi inicializado em g(x)recebendo apenas 1 parametro exatamente como ele está
# contruído, mas se em g(x) ele fosse inicializado recebendo 2 parametros, o compilador apontaria um erro,
# porque o f(x) está esperando apenas 1 parametro

# QUESTÃO 4