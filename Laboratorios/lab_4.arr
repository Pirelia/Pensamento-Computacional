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
#|
CONTATO-ANA = usuario("Ana", avatar-contato("Ana"), true)
CONTATO-EU = usuario("Eu", avatar-contato("Eu"), true)
MSG-TESTE-1 = msg-texto("Ana", "09:00", "Oi! Tudo bem?")
MSG-TESTE-2 = msg-texto("Eu", "09:01", "Tudo ótimo!")
MSG-TESTE-3 = msg-imagem("Ana", "09:02", square(30, "solid", "blue"), "Exemplo de figura")
CHAT-TESTE = chat(CONTATO-ANA, [list: MSG-TESTE-1, MSG-TESTE-2, MSG-TESTE-3])
|#

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
  doc: "Dada uma mensagem e o nome de um autor, devolve true se a mensagem foi enviada por este autor, caso contrário devolve false."
  cases (Mensagem) m:
    | msg-texto(a, h, t) => a == autor
    | msg-imagem(a, h, img, legenda) => a == autor
  end
where:
  eh-do-autor(MSG-TESTE-1, "Ana") is true
  eh-do-autor(MSG-TESTE-2, "Ana") is false
  eh-do-autor(MSG-TESTE-3, "Ana") is true
end


# 1.2
fun my-filter(f :: (Mensagem -> Boolean), l :: List<Mensagem>) -> List<Mensagem>:
  doc: "Dada uma função de critério (que recebe uma mensagem e devolve um booleano) e uma lista de mensagens, devolve uma nova lista com apenas as mensagens para as quais o critério devolve true."
  # Se a lista for vazia, então [...]
  # Senão, verifica se a primeira mensagem satisfaz o critério:
  #   Se satisfaz, [...]
  cases (List<Mensagem>) l:
    | empty => empty
    | link(primeiro, resto) =>
        if f(primeiro):
          link(primeiro, my-filter(f, resto))
        #   Senão, [...]
        else:
          my-filter(f, resto)
        end
  end
where:
  my-filter(lam(m): true end, CHAT-TESTE.mensagens) is CHAT-TESTE.mensagens
  my-filter(lam(m): eh-do-autor(m, "Eu") end, CHAT-TESTE.mensagens) is [list: MSG-TESTE-2]
end


# 1.3
fun filtra-autor(c :: Chat, autor :: String) -> Chat:
  doc: "Dado um chat e o nome de um autor, devolve um novo Chat com o mesmo contato e apenas as mensagens enviadas por este autor."
  # Reescreva o corpo desta função usando my-filter e eh-do-autor
  chat(c.contato, my-filter(lam(m): eh-do-autor(m, autor) end, c.mensagens))
where:
  filtra-autor(CHAT-TESTE, "Eu") is chat(CONTATO-ANA, [list: MSG-TESTE-2])
end

# Descomente a linha abaixo para visualizar apenas as mensagens da Ana no chat longo:
desenha-chat(filtra-autor(CHAT-LONGO, "Ana"))


#|
    Exercício 2: Map
|#

fun my-map(f :: (Mensagem -> Any), l :: List<Mensagem>) -> List<Any>:
  doc: "Dada uma função (que recebe uma mensagem e devolve um valor qualquer) e uma lista de mensagens, devolve uma nova lista com o resultado da aplicação da função a cada mensagem."
  # Se a lista for vazia, então [...]
  # Senão, [...]
  cases (List<Mensagem>) l:
    | empty => empty
    | link(first, rest) =>
        link(f(first), my-map(f, rest))
  end
where:
  my-map(is-msg-texto, CHAT-TESTE.mensagens) is [list: true, true, false]
  my-map(lam(m): m.horario end, CHAT-TESTE.mensagens) is [list: "09:00", "09:01", "09:02"]
  my-map(lam(m): edita-mensagem(m, "Oi!") end, [list: MSG-TESTE-2]) is [list: msg-texto("Eu", "09:01", "Oi!")]
end

# Descomente a linha abaixo para obter a lista com os autores de todas as mensagens do chat longo:
my-map(lam(m): m.autor end, CHAT-LONGO.mensagens)


#|
    Exercício 3: Fold
|#

# 3.1
fun my-fold<T>(f :: (T, T -> T), acc :: T, l :: List<T>) -> T:
  doc: "Dada uma função (que recebe dois valores do tipo T e devolve um valor do tipo T), um valor inicial para o acumulador e uma lista, devolve o resultado de aplicar a função sequencialmente ao acumulador e a cada elemento da lista."
  # Se a lista for vazia, então [...]
  # Senão, [...]
  cases (List<T>) l:
    | empty => acc
    | link(first, rest) =>
        my-fold(f, f(acc, first), rest)
  end
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
  mensagens-texto = my-filter(is-msg-texto, c.mensagens)  # Complete usando my-filter

  # Passo 2 (map): transforma cada mensagem de texto na quantidade de caracteres do seu texto
  # Dica: use uma expressão lambda e a função string-length
  tamanhos = my-map(lam(m):
    cases (Mensagem) m:
      | msg-texto(a, h, t) => string-length(t)
      | msg-imagem(a, h, img, legenda) => 0
    end
  end, mensagens-texto)  # Complete usando my-map

  # Passo 3 (fold): soma todas as quantidades de caracteres
  # Dica: veja os exemplos de my-fold acima
  my-fold(lam(a, b): a + b end, 0, tamanhos)
  # Complete usando my-fold
where:
  # CHAT-TESTE tem 2 mensagens de texto: "Oi! Tudo bem?" (13 caracteres) e "Tudo ótimo!" (11 caracteres)
  total-caracteres(CHAT-TESTE) is 24
  # Um chat sem mensagens de texto tem 0 caracteres
  total-caracteres(chat(CONTATO-ANA, [list: MSG-TESTE-3])) is 0
end

# Descomente a linha abaixo para calcular o total de caracteres do chat longo:
total-caracteres(CHAT-LONGO)


# 3.3
fun galeria-imagens(c :: Chat) -> Image:
  doc: "Dado um chat, gera uma imagem com todas as imagens enviadas no chat (msg-imagem), dispostas lado a lado."
  # Siga os mesmos 3 passos de total-caracteres, combinando my-filter, my-map, my-fold e beside
  mensagens-imagem = my-filter(is-msg-imagem, c.mensagens)

  imagens = my-map(lam(m):
    cases (Mensagem) m:
      | msg-texto(a, h, t) => empty-image
      | msg-imagem(a, h, img, legenda) => img
    end
  end, mensagens-imagem)

  my-fold(beside, empty-image, imagens)
where:
  galeria-imagens(chat(CONTATO-ANA, empty)) is empty-image
  galeria-imagens(chat(CONTATO-ANA, [list: MSG-TESTE-3])) is square(30, "solid", "blue")
end

# Descomente a linha abaixo para visualizar a galeria de imagens do chat longo:
galeria-imagens(CHAT-LONGO)