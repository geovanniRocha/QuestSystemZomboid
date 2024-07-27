# Todo:

- Logica do item, fazer o item funcionar quando chegar no lugar
- Mostrar mensagem dizendo que deu certo o item
- Multiplayer compativel
- Criar uma imagem melhor para sinalizar no mapa o local


# Roadmap
* Cria uma nova classe: Doutor (comeca com o mapa e com o bloco de anotações)
* Utilizar o item do doutor para poder fazer progresso na pesquisa
* Para pesquisar, chegar perto do lugar (calcular distancia) e se estiver a 100metros proximo, passar para o proximo waypoint

Fazer tudo isso funcionar com o multiplayer ( quando outro player pegar os itens, ele estarem de acordo, o mapa no waypoint correto e a proxima pesquisa ok)
DONE * Criar varios waypoints
DONE * Fazer o mapa atualizar em relação ao progresso da pesquisa

Não fazer* Criar uma UI para mostrar o progresso, no caso quais anotacoes e quais waypoints ja passaram (waypoint alpha, bravo ... zulu), quando selecionar o waypoint, atualizar o mapa para mostrar o waypoiny (colocar uma mudanca de cor para sinalizar que ja foi feito)


## Itens
* Bloco de anotações
* Mapa do proximo ponto de pesquisa


# Ideias
* Um mapa que atualize e marque os pontos que ja foram passados


poi.filter(x=>x.name.match(/Doctor|Hospital|Graveyard|fire|Fire|Pet|Police|Military|Prison|prison|Medical|Book|book|ValuTech|Cemetary/))