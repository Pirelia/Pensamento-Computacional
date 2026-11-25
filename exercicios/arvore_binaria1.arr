use context starter2024

# Ancestral Mulher com Mais de 40 Anos

data Pessoa:
    | nao-informada
    | pessoa(
        nome :: String,
        idade :: Number,
        sexo :: String,
        pai :: Pessoa,
        mae :: Pessoa
    )
end


AVO-TESTE = pessoa("Maria", 65, "mulher", nao-informada, nao-informada)

PAI-TESTE = pessoa("Carlos", 50, "homem", nao-informada, AVO-TESTE)

MAE-TESTE = pessoa("Ana", 30, "mulher", nao-informada, nao-informada)

PESSOA-TESTE = pessoa("Joao", 20, "homem", PAI-TESTE, MAE-TESTE)


fun ancestral-mulher-mais-40(p :: Pessoa) -> Boolean:
    doc:"Função, que dado uma pessoa, verifica se algum dos seus ancestrais é uma mulher com mais de 40 anos"

    cases(Pessoa) p:
        | nao-informada =>
            false
        | pessoa(nome, idade, sexo, pai, mae) =>
            if (sexo == "mulher") and (idade > 40):
                true
            else:
                ancestral-mulher-mais-40(pai) or ancestral-mulher-mais-40(mae)
            end
    end
where:
    ancestral-mulher-mais-40(PESSOA-TESTE) is true
    ancestral-mulher-mais-40(PAI-TESTE) is true
    ancestral-mulher-mais-40(MAE-TESTE) is false
    
end