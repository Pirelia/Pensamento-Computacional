use context starter2024

data GeoList:
    | retangulo(largura :: Number, altura :: Number)
    | circulo(raio :: Number)
    | triangulo(base :: Number, altura :: Number)
end

lista-formas = [list:
  retangulo(10, 5),
  circulo(3),
  triangulo(4, 6),
  retangulo(8, 2)
]


fun eh-retangulo(gl :: GeoList) -> Boolean:
    doc:"Função para filtrar os retangulos da Lista GeoList, se o caso fo satisfazível, true"

    cases(GeoList)gl:
        | retangulo(l, a) => true
        | circulo(r) => false
        | triangulo(b, a) => false
    end
end


fun eh-circulo(gl :: GeoList) -> Boolean:
    doc:"Função para filtrar os retangulos da Lista GeoList, se o caso fo satisfazível, true"

    cases(GeoList)gl:
        | retangulo(l, a) => false
        | circulo(r) => true
        | triangulo(b, a) => false
    end
end

fun eh-triangulo(gl :: GeoList) -> Boolean:
    doc:"Função para filtrar os retangulos da Lista GeoList, se o caso fo satisfazível, true"

    cases(GeoList)gl:
        | retangulo(l, a) => false
        | circulo(r) => false
        | triangulo(b, a) => true
    end
end



fun filtra-formas(criterio :: (GeoList -> Boolean), formas :: List<GeoList>) -> List<GeoList>:
    doc:"dada uma lista de formas, filtra apenas os retangulos"

    filter(criterio, lista-formas)

where:
    filtra-formas(eh-retangulo, lista-formas) is link(retangulo(10, 5), link(retangulo(8, 2), empty))
    filtra-formas(eh-circulo, lista-formas) is link(circulo(3), empty)
    filtra-formas(eh-triangulo, lista-formas) is link(triangulo(4, 6), empty)
end


