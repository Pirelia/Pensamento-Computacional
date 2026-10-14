
#|
    Este arquivo contém o template para a solução dos exercícios do Laboratório 4 de INF05008 - Pensamento Computacional.

    Autor: Prof. Lucas N. Alegre
|#

include image
# Importa as estruturas, funções e constantes da biblioteca de chat (incluindo o que foi desenvolvido no Laboratório 3)
include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/chat-lib4.arr")

# ATENÇÃO: As estruturas Usuario, Mensagem e Chat já estão definidas na biblioteca. Não as redefina neste arquivo!


#|
    Constantes (fornecidas prontas)
|#

# Constantes de teste da biblioteca, que você pode usar nos seus exemplos (where:):
CONTATO-ANA = usuario("Ana", avatar-contato("Ana"), true)
CONTATO-EU = usuario("Eu", avatar-contato("Eu"), true)
MSG-TESTE-1 = msg-texto("Ana", "09:00", "Oi! Tudo bem?")
MSG-TESTE-2 = msg-texto("Eu", "09:01", "Tudo ótimo!")
MSG-TESTE-3 = msg-imagem("Ana", "09:02", square(30, "solid", "blue"), "Exemplo de figura")
CHAT-TESTE = chat(CONTATO-ANA, [list: MSG-TESTE-1, MSG-TESTE-2, MSG-TESTE-3])

# Chat curto com a Ana, contendo as 6 primeiras mensagens da tabela online:
CHAT-CURTO = chat(usuario("Ana", avatar-contato("Ana"), true), cria-historico-tabela([list: 1, 2, 3, 4, 5, 6]))

# Visualize os chats (o CHAT-LONGO, da biblioteca, contém todas as 20 mensagens da tabela):
desenha-chat(CHAT-CURTO)
desenha-chat(CHAT-LONGO)


#|
    Exercício 1: Filter
|#

# 1.1 Complete o contrato, o objetivo, o corpo e os exemplos da função abaixo.
fun eh-do-autor(m :: Mensagem, autor :: String) -> Boolean:
    doc:"Dada uma mensagem e o nome de um autor, devolve true se a mensagem foi enviada por este autor, caso contrário devolve false."
  ask:
    |m.autor == autor then: true
    |otherwise: false
  end
  
  false
where:
  true is true
end

# 1.2
fun my-filter(f :: (Mensagem -> Boolean), l :: List<Mensagem>) -> List<Mensagem>:
  doc: "Dada uma função de critério (que recebe uma mensagem e devolve um booleano) e uma lista de mensagens, devolve uma nova lista com apenas as mensagens para as quais o critério devolve true."
  # Se a lista for vazia, então [...]
  # Senão, verifica se a primeira mensagem satisfaz o critério:
  #   Se satisfaz, [...]
    ask:
    |empty => empty
    |link(primeiro, resto) =>
        if 
        f(primeiro) then: 
        link(primeiro, myfilter(f, resto))
        
  #   Senão, [...]
        else: 
        myfilter(f, resto)
  empty
where:
  true is true
  # my-filter(lam(m): true end, CHAT-TESTE.mensagens) is CHAT-TESTE.mensagens
  # my-filter(lam(m): eh-do-autor(m, "Eu") end, CHAT-TESTE.mensagens) is [list: MSG-TESTE-2]
end

# 1.3
fun filtra-autor(c :: Chat, autor :: String) -> Chat:
  doc: "Dado um chat e o nome de um autor, devolve um novo Chat com o mesmo contato e apenas as mensagens enviadas por este autor."
  # Reescreva o corpo desta função usando my-filter e eh-do-autor
  c
where:
  true is true
end

# Descomente a linha abaixo para visualizar apenas as mensagens da Ana no chat longo:
# desenha-chat(filtra-autor(CHAT-LONGO, "Ana"))


#|
    Exercício 2: Map
|#

fun my-map(f :: (Mensagem -> Any), l :: List<Mensagem>) -> List<Any>:
  doc: "Dada uma função (que recebe uma mensagem e devolve um valor qualquer) e uma lista de mensagens, devolve uma nova lista com o resultado da aplicação da função a cada mensagem."
  # Se a lista for vazia, então [...]
  # Senão, [...]
  empty
where:
  true is true
  # my-map(is-msg-texto, CHAT-TESTE.mensagens) is [list: true, true, false]
end

# Descomente a linha abaixo para obter a lista com os autores de todas as mensagens do chat longo:
# my-map(lam(m): m.autor end, CHAT-LONGO.mensagens)


#|
    Exercício 3: Fold
|#

# 3.1
fun my-fold<T>(f :: (T, T -> T), acc :: T, l :: List<T>) -> T:
  doc: "Dada uma função (que recebe dois valores do tipo T e devolve um valor do tipo T), um valor inicial para o acumulador e uma lista, devolve o resultado de aplicar a função sequencialmente ao acumulador e a cada elemento da lista."
  # Se a lista for vazia, então [...]
  # Senão, [...]
  acc
where:
  my-fold(lam(a, b): a + b end, 0, [list: 1, 2, 3, 4, 5]) is 15
  my-fold(lam(a, b): a * b end, 1, [list: 1, 2, 3]) is 6
  my-fold(string-append, "", [list: "Oi", "! ", "Tudo bem?"]) is "Oi! Tudo bem?"
end

# 3.2
fun total-caracteres(c :: Chat) -> Number:
  doc: "Dado um chat, devolve a quantidade total de caracteres dos textos das mensagens de texto (msg-texto) do chat."
  # Passo 1 (filter): seleciona apenas as mensagens de texto do chat
  # Dica: use a função is-msg-texto como critério
  mensagens-texto = empty  # Complete usando my-filter

  # Passo 2 (map): transforma cada mensagem de texto na quantidade de caracteres do seu texto
  # Dica: use uma expressão lambda e a função string-length
  tamanhos = empty  # Complete usando my-map

  # Passo 3 (fold): soma todas as quantidades de caracteres
  # Dica: veja os exemplos de my-fold acima
  0  # Complete usando my-fold
where:
  # CHAT-TESTE tem 2 mensagens de texto: "Oi! Tudo bem?" (13 caracteres) e "Tudo ótimo!" (11 caracteres)
  total-caracteres(CHAT-TESTE) is 24
  # Um chat sem mensagens de texto tem 0 caracteres
  total-caracteres(chat(CONTATO-ANA, [list: MSG-TESTE-3])) is 0
end

# Descomente a linha abaixo para calcular o total de caracteres do chat longo:
# total-caracteres(CHAT-LONGO)

# 3.3
fun galeria-imagens(c :: Chat) -> Image:
  doc: "Dado um chat, gera uma imagem com todas as imagens enviadas no chat (msg-imagem), dispostas lado a lado."
  # Siga os mesmos 3 passos de total-caracteres, combinando my-filter, my-map, my-fold e beside
  empty-image
end

# Descomente a linha abaixo para visualizar a galeria de imagens do chat longo:
# galeria-imagens(CHAT-LONGO)
