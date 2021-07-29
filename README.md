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

Após a disponibilização, crie um link simbólico:
```shell
ln -s ufsc-thesis-rn46-2019/ufsc-thesis-rn46-2019.cls
```

... e use a classe:

```tex
\documentclass[]{ufsc-thesis-rn46-2019}
```

> Até dezembro de 2020, o link simbólico não era necessário pois o texlive-core
> era tolerante a `\documentclass{ufsc-thesis-rn46-2019/ufsc-thesis-rn46-2019}`,
> gerando apenas um warning. Nas versões atuais, esse tipo de uso fará com que
> opções fornecidos no \documentclass sejam **silenciosamente ignoradas**. O
> problema mais comum são erros relacionados ao arquivo `ufsc-logo.pdf` para
> usuários usando a opção `embeddedlogo`.


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

### O overleaf não compila e acusa "output-logo.pdf not found"

Isso ocorre caso seja usada a opção `embeddedlogo` (recomendado para o overleaf) mas o arquivo .tex principal (aquele que faz o `\documentclass{ufsc-thesis-rn46-2019}`) não está na raiz do projeto. Para resolver, mova o .tex principal para a raiz do projeto. Lembre que o arquivo `ufsc-thesis-rn46-2019.cls` assim como o `.cls` de classes derivadas (como a [lapesd-thesis](https://github.com/lapesd/lapesd-thesis)) precisa estar "ao lado" (i.e., no mesmo diretório) do arquivo `.tex` principal.

Esse problema pode ocorrer quando o usuário importa seu projeto para o overleaf usando um `.zip` que contenha outra pasta dentro. O problema pode ser difícil de diagnosticar, mas verifique na aba direita do overleaf, onde são listados os arquivos se existe uma pasta raiz que quando colapsada (o `v` à esquerda se transforma em um `>`) oculta o seu `.tex` principal. Para resolver a situação, arresta cada pasta/arquivo dentro dessa pasta raiz para fora da pasta raiz. 

Caso você propositalmente tenha criado o arquivo `.tex` principal dentro de algum subdiretório do projeto, infelizmente a opção `embeddedlogo` é incompatível. Omita essa opção ou suprima o seu uso caso esteja usando uma classe derivada desta. Lembre que sem essa opção, é necessário copiar o arquivo [logo-ufsc.pdf](logo-ufsc.pdf) neste repositório para o seu projeto (ao lado do `.tex` principal ou em algum lugar no `\graphicspath`). 

### Preciso fazer com que algumas páginas não sejam contabilizadas

Alguns programas impõem um limite máximo de páginas para documentos. Você pode fazer com que elementos pré-textuais não sejam contabilizados forçando com que a Introdução comece na página 1. Basta colocar `\setcounter{page}{1}` antes do `\section{Introduction}`. Note que isso causará warnings como esse:

```
pdfTeX warning (ext4): destination with the same identifier (name{page.2})
has been already used, duplicate ignored
```

Esses warnings são inofensivos. Para eliminá-los, siga esses passos:

1. Passe a opção `nopageanchorhack` para a classe
2. Adicione `\hypersetup{pageanchor=false}` antes de `\imprimircapa`
3. Adicione `\hypersetup{pageanchor=true}` após o `\setcounter{page}{1}`

### Como gerar um arquivo PDF/A?

#### Conversor [online](http://pdfa.bu.ufsc.br/) da BU
Tem a facilidade de ser online, mas possui alguns problemas:

1. Pode causar artefatos em imagens e em todo o texto de uma página que tenha imagens. 
2. De acordo com o validador de referência [VeraPDF](https://verapdf.org/software/), o resultado do conversor possui algumas violações do padrão PDF/A-1b que o PDF resultante declara aderir. 

#### Ghostscript 
Disponível em praticamente qualquer ambiente linux e produz resultados sem artefatos (confirme isso para o seu documento). O processo envolve mais de um comando, logo recomenda-se usar esse [script](https://github.com/alexishuf/pdfa-gs-converter/releases/download/v0.1/pdfa-gs-converter.sh):

```{bash}
pdfa-gs-converter.sh arquivo.pdf arquivo-pdfa.pdf
```

Explicações e detalhes estão no [repositório](https://github.com/alexishuf/pdfa-gs-converter/). O resultado deve ser um PDF/A-1b usando o formato 1.4 (ao invés do 1.7 usado pelos PDF/A-2 e PDF/A-3).

#### Pacote pdfx

Na versão atual, o [pacote](https://ctan.org/pkg/pdfx) resiste em embarcar algumas fontes (causando não conformidades) e há dificuldades técnicas para incorporá-lo na classe ufsc-thesis-rn46-2019 para tornar seu uso transparente. Se você está cogitando usar esse pacote, considere testar Ghostscript antes: para a maioria dos casos ele deve ser suficiente e exigirá menos esforço.

#### Impressora virtual (Windows)
Essa é a solução [indicada pela própria BU](http://portal.bu.ufsc.br/files/2019/11/Manual_Solucionando-qualidade-grafica-ruim-no-arquivo-PDF.pdf) para os artefatos do conversor online. 

#### Validando o arquivo PDF/A

É possível validar o PDF/A resultante de qualquer ferramenta usando o [VeraPDF](https://verapdf.org/software/). Use a opção `-f 1b` para validar o formato 1b, que supõe-se ser o exigido pela BU já que é esse formato que a ferramenta oficial tenta produzir. No Linux, é possível ver os metadados PDF/A com o comando `exiftool -a -G1 arquivo.pdf` (pacote [perl-image-exiftool](https://search.cpan.org/perldoc?exiftool)). Leitores de PDF e o comando `pdfinfo` usualmente mostram apenas metadados PDF e não os PDF/A.

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

