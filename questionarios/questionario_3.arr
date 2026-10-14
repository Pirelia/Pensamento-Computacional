use context starter2024

# Declaração de um tipo de dado para representar um jogador de bocha
 
# palavra-chave que inicia o declaração do tipo de dado "data"
data Jogador: # nome do tipo dado definido "Jogador"
    
    jogador( # Construtor declaração de uma variante do tipo Jogador. 
             # O nome jogador também identifica a função construtora que será usada para criar valores dessa variante.
        nome :: String, 
        vitorias :: Number,
        derrotas :: Number
    )

end 

data Dupla:
    dupla(
        nome ::  String,
        emblema :: Image,
        jogador1 :: Jogador,
        jogador2 :: Jogador
    )
end

# Função que compara o numero de vitorias dos dois jogadores e returna True se o jogador 1 tiver mais vitorias que o jogador 2, caso contrário retorna False
fun mais-vitorias(j1 :: Jogador, j2 :: Jogador) -> Boolean:
  doc: "Retorna True se o jogador 1 tem mais vitórias que o jogador 2."
  j1.vitorias > j2.vitorias
where:
  mais-vitorias(jogador("Nicolas", 4, 2), jogador("Henrique", 8, 3)) is false
end

fun analisa-dupla(dup :: Dupla) -> String:
  doc: "Retorna uma string com o nome do jogador com mais vitórias,  caso o valor de vitórias for igual retorna uma String 'Os dois jogadores tem o mesmo número de vitórias!'."

  ask:
    |mais-vitorias(dup.jogador1, dup.jogador2) then: dup.jogador1.nome
    |mais-vitorias(dup.jogador2, dup.jogador1) then: dup.jogador2.nome
    |otherwise: "Os dois jogadores tem o mesmo número de vitórias!"

  end

where:
    analisa-dupla(dupla("Os Dentistas da Sinuca do DACOMP", empty-image,jogador("Nicolas",  4, 2), jogador("Henrique", 8, 3))) is "Henrique"
    analisa-dupla(dupla("Os Dentistas da Sinuca do DACOMP", empty-image,jogador("Pedro", 8, 3), jogador("Pedro", 4, 2))) is "Pedro"
    analisa-dupla(dupla("Os Dentistas da Sinuca do DACOMP", empty-image,jogador("Pedro", 4, 2), jogador("Pedro", 4, 2))) is "Os dois jogadores tem o mesmo número de vitórias!"
end