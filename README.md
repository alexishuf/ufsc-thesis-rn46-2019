# ufsc-thesis-rn46-2019

Essa classe LaTeX estende a classe abnTeX2 para atender as novas normas específicas à UFSC publicadas pela BU da UFSC em virtude da RN nº 46/2019/CPG que entrou em vigência em 1 de Agosto de 2019.

Referências normativas relevantes consideradas no desenvolvimento dessa classe:

- [Resolução Normativa nº 46/2019/CPG](https://repositorio.ufsc.br/handle/123456789/197121)
- [Template Word oficial](https://repositorio.ufsc.br/handle/123456789/197457)
- [Tutorial oficial de configuração do Word](https://repositorio.ufsc.br/handle/123456789/198045)
- [Tutorial oficial sobre as normas de formatação ABNT da BU](https://repositorio.ufsc.br/handle/123456789/180829)

A classe tenta uma boa compatibilidade com o abnTeX. No entanto a BU tem algumas exigências que motivaram a criação de novos comandos como `\programa{}`, `\tese`, `\dissertacao` e `\titulode{Doutor em Ciência da Computação}`.

Embora o manual pareça longo, ele o é apenas pois demonstra vários elementos pré-textuais. A seção de quickstart possui apenas 2 páginas e deve ser suficiente. A seção de problemas conhecidos tem uma página e sua leitura é **fortemente** recomendada.

A leitura da documentação do abnTeX também é recomendada. Essa classe foi inspirada na [ufsc-thesis](https://github.com/mateusduboli/ufsc-thesis-latex), embora pouco tenha restado.

Essa classe foi uma iniciativa do Alexis Armin Huf e do Gustavo Zambonin, alunos do PPGCC/UFSC. Contribuições e issues são bem-vindos!

## Manual 

Leia o [manual completo aqui](https://github.com/alexishuf/ufsc-thesis-rn46-2019/raw/master/doc/userguide.pdf).

## Como usar?

Há três modos principais.

### Overleaf

Copie [esse projeto no overleaf](https://www.overleaf.com/read/xqcswqpqyjpz). Uma vez copiado você deverá atualizar a classe baixando o .cls desse repositório e substituindo na sua cópia.

### Submodulo/Diretório

Disponibilize esse repositório como um subdiretório do seu projeto. Isso pode ser feito de três formas:

1. `git submodule add https://github.com/alexishuf/ufsc-thesis-rn46-2019` 
2. `git clone https://github.com/alexishuf/ufsc-thesis-rn46-2019`
3. Use a opção download as zip do github e extraia o zip dentro do seu projeto.

**Dica:** ao usar as opções git, você pode incluir a opção `--depth 1` para evitar baixar todo o histórico de commits.

Após a disponibilização, você deve usar a classe:

```tex
\documentclass[]{ufsc-thesis-rn46-2019}
```

Se você mudou o nome ou local do diretório de uma forma que o .cls não consegue adivinhar onde ele está, você deverá alterar o `\graphicspath{}` para incluir o diretório onde está o arquivo .cls. O chute padrão da classe é esse:

```tex
\graphicspath{%
  {.}%
  {ufsc-thesis-rn46-2019/}%
  {../ufsc-thesis-rn46-2019/}%
}
```

**Dica:** Se estiver em um ambiente UNIX-like, você pode evitar chateações com o caminho do logo-ufsc.pdf usando a opção `embeddedlogo` na classe.

### Modo rústico

No modo rústico você simplesmente copia o arquivo .cls (e nada mais) e coloca no seu projeto LaTeX. O .cls possui o logo da UFSC embarcado, mas você precisa solicitar o uso dessa feature:

```tex
\documentclass[embeddedlogo]{ufsc-thesis-rn46-2019}
```

Esse modo é o usado no overleaf. Se você estiver trabalhando localmente, precisará estar em um ambiente UNIX-like e adicionar a opção `-shell-escape` ao compilar:

```bash
pdflatex -shell-escape arquivo.tex
```

## FAQ

### Agora a BU possui um template LaTeX, qual devo usar?

Siga seu coração, jovem. As principais diferenças são:

1. Essa classe é minimamente intrusiva;
2. Essa classe fornece apenas formatação e detecta pacotes para corrigir algumas incompatibilidades;
3. Essa classe tenta emular o template do Word, que é o mais ativamente mantido pela BU;
4. Há muitos alunos e poucos bibliotecários, mas nessa classe qualquer um pode abrir um PR.

A diferença 1 implica que nenhum pacote relevante que já não seja carregado pelo próprio abnTeX2 (como o hyperref) será carregado. O objetivo é evitar que a classe carrega algum pacote incompatível com outro que o usuário quer usar. Exemplos de problemas são acronym vs. glossaries, listings vs. minted e opções de \usepackage{}. A diferença 2 significa que ninguém vai ficar frustado pois o template separa a dissertação em 27 arquivos com hard wraps. Sua dissertação, suas regras. A segunda consequência é que bug fixes na classe não precisam de um diff no `main.tex`: basta trocar o `.cls` (ou fazer um `git pull` no submodule). A diferença 3 é uma última linha de defesa para o caso onde o template LaTeX da BU fique sem atualização. Nem todo bibliotecário tem disponibilidade de alterar o LaTex quando descobrem um erro no template.

Independetemente do template que escolher, lembre que **é possível cometer erros com os dois** e os dois podem ter erros. Submeta sua dissertação/tese com antecedência maior do que 15 dias úteis.


### A BU usa Arial, por que essa classe usa Times?

A BU usa Arial como exemplo, mas no template word autoriza uso de Times. Fontes serifadas (como Times) são tradicionais em livros impressos e são exigidas em inúmeras editoras científicas, como Elsevier, Springer, IEEE, ACM e SBC. Já fontes sans-serif são mais comuns na internet e em contextos mais informais como magazines (não confundir com journals). Dissertações são essecialmente pequenos livros com conteúdo científico, por isso uma fonte serifada é uma escolha mais adequada. Caso queira algo mais (literalmente) moderno que Times New Roman, você pode usar Latin Modern via a opção de classe `lmodern` ou outras fontes manualmente importando seus pacotes. Cuidado: embora a BU já tenha aceito dissertações usando Latin Modern, apenas Arial ou Times são mencionadas pela BU.

### Legal, mas e como eu faço uma dissertação com isso?

Leia o [manual em doc/userguide.pdf](https://github.com/alexishuf/ufsc-thesis-rn46-2019/raw/master/doc/userguide.pdf). Logo na introdução há um quickstart de 2 páginas que cobre tudo que é importante. É sempre uma boa ideia consultar o capítulo de referência das opções da classe e de comandos.

### Há um preview ou exemplo?

O [manual](https://github.com/alexishuf/ufsc-thesis-rn46-2019/raw/master/doc/userguide.pdf) é escrito usando a própria classe e o código fonte está disponível no diretório `doc/`. Se quiser algo mais parecido com uma dissertação/tese, veja o [exemplo no overleaf](https://www.overleaf.com/read/xqcswqpqyjpz). Se quiser um exemplo de como criar uma classe que customiza essa para uso no seu laboratório ou grupo de pesquisa, veja [este exemplo do Lapesd/INE](https://github.com/lapesd/lapesd-thesis).

### Não gostei dos exemplos, não há um exemplo mais *X*?

Há vários! Essa mudança de regras da RN 46/2019/CPG mudou principalmente procedimentos de entrega e detalhes de formatação. Todos os exemplos de como fazer uma dissertação com abnTeX2 e os templates antigos aqui da UFSC continuam aplicáveis, exceto pela formatação. Você apenas precisa cuidar para não copiar configurações de formatação dos templates já em circulação.

O próprio [repositório do abnTeX2](https://github.com/abntex/abntex2) aqui no github possui referências interessantes. Se estiver em dúvida sobre a ordem dos elementos necessários e opcionais, uma fonte rápida de consulta é o próprio [documento da BU sobre ABNT](https://repositorio.ufsc.br/handle/123456789/180829).

### Eu tenho um template que gosto muito, como passar a usar essa classe?

A sua situação provavelmente se encaixa em um de três casos.

**No caso 1**, seu template é um pacote (arquivo .sty) e na dissertação o aluno faz um `\usepackage{}` após o `\documentclass[abntex2]`. Há duas soluções possíveis:

1. Editar o .sty do pacote e apagar as instruções de formatação
2. Deixar de importar esse pacote antigo.

**No caso 2**, seu template é um arquivo .cls que carrega o abntex2 via `\LoadClass{abntex2}` (um exemplo é a [ufsc-thesis](https://github.com/mateusduboli/ufsc-thesis-latex) original). O seu .cls pode ser atualizado para as novas regras seguindo esses passos:

1. Troque `\LoadClass[]{abntex2}`  por `\LoadClass[]{ufsc-thesis-rn46-2019}`
2. Remova do seu .cls todas as instruções de formatação (margens, fontes, espaçamentos, bibliografia, etc.)

**No caso 3**, seu template é um arquivo .tex que faz um `\documentclass{abntex2}` ou `\documentclass{ufsc-thesis}`. Simplesmente troque abntex2 por essa classe e remova instruções de formatação que existam.

## Quais são as mudanças além do da página A4?

Há uma profusão de templates já usados na UFSC, com vários níveis de aderências às antigas normas da BU. A seguir seguem as principais alterações em relação à classe abnTeX2 que são específicas da UFSC:

* Capa específica da UFSC, com brasão
* Folha de rosto (incluindo texto do preâmbulo que essa classe gera)
* Uso apenas do ano na capa e folha de rosto
* Folha de certificação (modelo exclusivo da UFSC)
* Cabeçalho e rodapé sem filete e nome de seção
* Formatação de títulos de seção (escala de caixa alta, negrito e itálico)
* Sumário deve manter destaques usados nos títulos de seção
* Numeração de página deve manter mesmo tamanho de fonte (10pt) mesmo na abertura de capítulos
* Após títulos de capítulos e seções deve-se inserir o espaçamento equivalente a uma linha em branco
* Espaçamento 1,5 por todo o texto (exceto footnotes, referencias e floats)
* Fonte 10pt para floats, footnotes e cabeçalhos.
* Espaçamento entre parágrafos de 0cm
* Indentação do parágrafo de 1,5cm na primeira linha, que no deve ser aplicada em títulos
* Itens das referências devem ser separados pelo equivalente à uma linha em branco
* O destaque de títulos nas referências deve ser negrito

Existe um rastreamento das regras implementadas como comentários nos neste [PDF](https://github.com/alexishuf/ufsc-thesis-rn46-2019-test/raw/master/regulations/tutorial-word.pdf) da BU e neste [outro](https://github.com/alexishuf/ufsc-thesis-rn46-2019-test/raw/master/regulations/tutorial-abnt.pdf).

