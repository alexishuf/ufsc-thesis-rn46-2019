# ufsc-thesis-rn46-2019

Essa classe LaTeX extende a classe abnTeX2 para atender as novas normas específicas à UFSC publicadas pela BU da UFSC em virtude da RN nº 46/2019/CPG que entrou em vigência em 1 de Agosto de 2019.

Referências normativas relevantes consideradas no desenvolvimento dessa classe:

- [Resolução Normativa nº 46/2019/CPG](https://repositorio.ufsc.br/handle/123456789/197121)
- [Template Word oficial](https://repositorio.ufsc.br/handle/123456789/197457)
- [Tutorial oficial de configuração do Word](https://repositorio.ufsc.br/handle/123456789/198045)
- [Tutorial oficial sobre as normas de formatação ABNT da BU](https://repositorio.ufsc.br/handle/123456789/180829)

## Como usar?

Há dois modos principais.

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
  {../../ufsc-thesis-rn46-2019/}%
}
```

**Dica:** Se estiver em um ambiente UNIX-like, você pode evitar chateações com o caminho do logo-ufsc.pdf usando a opção `embeddedlogo` na classe.

### Modo rústico

No modo rústico você simplesmente copia o arquivo .cls (e nada mais) e coloca no seu projeto LaTeX. O .cls possui o logo da UFSC embarcado, mas vocẽ precisa solicitar o uso dessa feature:

```tex
\documentclass[embeddedlogo]{ufsc-thesis-rn46-2019}
```

Esse modo **funciona no [overleaf](https://www.overleaf.com/)** out of the box. Se você estiver trabalhando localmente, precisará estar em um ambiente UNIX-like e adicionar a opção `-shell-escape` ao compilar:

```bash
pdflatex -shell-escape arquivo.tex
```

## FAQ

### Legal, mas e como eu faço uma dissertação com isso?

Leia o [manual em doc/userguide.pdf](https://github.com/alexishuf/ufsc-thesis-rn46-2019/raw/master/doc/userguide.pdf). Logo na introdução há um quickstart de 2 páginas que cobre tudo que é importante. É sempre uma boa idéia consultar o capítulo de referência das opções da classe e de comandos.

### Há um preview ou exemplo?

O [manual](https://github.com/alexishuf/ufsc-thesis-rn46-2019/raw/master/doc/userguide.pdf) é escrito usando a própria classe e o código fonte está disponível no diretório `doc/`.

### Eu tenho um template que gosto muito, como passar a usar essa classe?

Há duas situações. Seu template faz um \documentclass{abntex2}? Se sim troque abntex2 por essa classe. Se você incluir um pacote que aplica as regras de formatação antigas da BU, há duas opções:

1. Editar o .sty do pacote e apagar as intruções de formatação
2. Deixar de importar esse pacote antigo.

Na segunda situação você está usando uma classe que customiza a abntex2, como é o caso da ufsc-thesis-rn46-2019 e da [ufsc-thesis](https://github.com/mateusduboli/ufsc-thesis-latex) de onde os autores dessa partiram. Logo você deveriá modificar a sua classe para trocar o `\LoadClass[]{abntex2}`  por `\LoadClass[]{ufsc-thesis-rn46-2019}`. Ao fazer isso a sua classe ainda vai sobreescrever as novas regras com as antigas. Basta navegar pelo código da sua classe e remover instruções relativas a formatação, deixando apenas as features super legais que estão faltando na `ufsc-thesis-rn46-2019`.
