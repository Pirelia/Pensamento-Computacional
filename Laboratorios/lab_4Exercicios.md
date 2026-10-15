### Exercício 1: Filter

- Escreva a função eh-do-autor que, dada uma Mensagem e o nome de um autor (String), devolve true se a mensagem foi enviada por este autor e false caso contrário.
- Escreva a função my-filter(f :: (Mensagem -> Boolean), l :: List<Mensagem>) -> List<Mensagem> que, dada uma função de critério (que recebe uma mensagem e devolve um booleano) e uma lista de mensagens, devolve uma nova lista com apenas as mensagens para as quais esta função devolve true.
- Escreva a função filtra-autor(c :: Chat, autor :: String) -> Chat que, dado um chat e o nome de um autor, devolve um novo Chat com o mesmo contato e apenas as mensagens enviadas por este autor.

### 🛠️ Dica:

Reutilize as funções my-filter e eh-do-autor no item 3.
A função eh-do-autor recebe dois argumentos, porém a função de critério f de my-filter recebe apenas um. Pense em como usar uma expressão lambda para que eh-do-autor possa ser usada em my-filter.
🚀 Experimente no Chat Longo: desenha-chat(filtra-autor(CHAT-LONGO, "Ana")) deve mostrar apenas os balões brancos da Ana!

## 🔄 Exercício 2: Map
Escreva a função my-map(f :: (Mensagem -> Any), l :: List<Mensagem>) -> List<Any> que, dada uma função que recebe uma mensagem e devolve um valor qualquer (Any) e uma lista de mensagens, devolve uma lista com os resultados da aplicação da função a cada mensagem da lista.

# 🛠️ Dica: Nos seus exemplos (where:), aplique diferentes funções às mensagens do CHAT-TESTE. Por exemplo:

my-map(lam(m): m.horario end, CHAT-TESTE.mensagens) deve devolver a lista de horários [list: "09:00", "09:01", "09:02"];
my-map(lam(m): edita-mensagem(m, "Oi!") end, [list: MSG-TESTE-2]) deve devolver [list: msg-texto("Eu", "09:01", "Oi!")].
🚀 Experimente no Chat Longo: my-map(lam(m): m.autor end, CHAT-LONGO.mensagens) devolve a lista com os autores de todas as mensagens, e my-map(desenha-mensagem, CHAT-CURTO.mensagens) devolve uma lista de imagens!

## 📦 Exercício 3: Fold
3.1 my-fold
- Escreva a função my-fold<T>(f :: (T, T -> T), acc :: T, l :: List<T>) -> T que, dada uma função (que recebe dois valores de um determinado tipo T e devolve um valor do mesmo tipo), um valor inicial para o acumulador e uma lista, devolve o resultado de aplicar esta função sequencialmente a todos os elementos da lista, dois a dois (acumulador e primeiro elemento, resultado e segundo elemento, ...).

O <T> indica que a função funciona para qualquer tipo T: números, strings, imagens etc. Os exemplos da cláusula where: já estão no template.

## 3.2 Total de caracteres
Escreva a função total-caracteres(c :: Chat) -> Number que, dado um chat, devolve a quantidade total de caracteres dos textos das mensagens de texto (msg-texto) do chat. Mensagens com imagem não devem ser contadas.

Para isso, vamos combinar as três funções de alta ordem em 3 passos. O template já traz o esqueleto da função e os exemplos:

fun total-caracteres(c :: Chat) -> Number:
  -  Passo 1 (filter): seleciona apenas as mensagens de texto do chat
  mensagens-texto = my-filter(..., c.mensagens)

  -  Passo 2 (map): transforma cada mensagem de texto na quantidade de caracteres do seu texto
  tamanhos = my-map(lam(m): ... end, mensagens-texto)

  - Passo 3 (fold): soma todas as quantidades de caracteres
  my-fold(..., ..., tamanhos)
end
Veja o que cada passo produz para o CHAT-TESTE:

- Passo	Resultado:

Mensagens do chat (c.mensagens)	[list: MSG-TESTE-1, MSG-TESTE-2, MSG-TESTE-3]
1. Apenas as mensagens de texto	[list: MSG-TESTE-1, MSG-TESTE-2]
2. Quantidade de caracteres de cada texto	[list: 13, 11]
3. Soma das quantidades	24
### 🛠️ Dicas:

- Passo 1: Para cada variante de uma estrutura de dados, o Pyret cria automaticamente uma função is-<variante>. Por exemplo, is-msg-texto(m) devolve true se m for uma msg-texto. Você pode passar essa função diretamente como critério para my-filter, sem precisar de uma lambda!
- Passo 2: A lambda recebe uma mensagem de texto m, cujo texto é m.texto. A função string-length devolve a quantidade de caracteres de uma string: string-length("Oi! Tudo bem?") é 13.
- Passo 3: Veja os exemplos de my-fold no template: qual função soma dois números? E qual deve ser o valor inicial do acumulador de uma soma?
## 3.3 Galeria de imagens
Em aplicativos de mensagens, podemos ver todas as imagens enviadas em uma conversa em uma galeria. Escreva a função galeria-imagens(c :: Chat) -> Image que, dado um chat, gera uma imagem com todas as imagens enviadas no chat (msg-imagem), dispostas lado a lado.

# 🛠️ Dica: Siga os mesmos 3 passos do item anterior: selecione as mensagens com imagem, transforme cada uma na imagem enviada (campo imagem) e junte as imagens lado a lado com beside. Lembre-se que o valor inicial do acumulador de uma imagem será empty-image.

🚀 Experimente no Chat Longo: Execute total-caracteres(CHAT-LONGO) e galeria-imagens(CHAT-LONGO) no painel de interações!