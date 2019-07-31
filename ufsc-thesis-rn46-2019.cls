% vim:et:sw=2
%% ufsc-thesis-rn46-2019.cls, a template that abides to changes introduced by RN 46/2019/CPG.
%% This class file was based on https://github.com/mateusduboli/ufsc-thesis-latex
%% - @rn46 The RN document: https://repositorio.ufsc.br/handle/123456789/197121
%% - @buDoc MS Word template: https://repositorio.ufsc.br/handle/123456789/197457
%% - @buWord MS Word Formatting guide: https://repositorio.ufsc.br/handle/123456789/198045
%% - @buABNT ABNT NBR 14721:2011 : https://repositorio.ufsc.br/handle/123456789/180829
%% - @ABNT ABNT NBR 14721:2011

% Define versão necessária do LaTeX
\NeedsTeXFormat{LaTeX2e}

% Prove acesso a classe 'ufsc-thesis'
\ProvidesClass{ufsc-thesis-rn46-2019}[2019/07/30 v0.1 ufsc-thesis-rn46-2019]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Declarações e tratamento inicial de opções                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [english]
% Ativa nomes de elementos (pré)textuais em inglês (secion, contents, table, figure, ...)
\newif\ifufscthesis@eng
\DeclareOption{english}{%
  \ufscthesis@engtrue%
  \PassOptionsToPackage{english}{babel}%
  \PassOptionsToClass{\CurrentOption}{abntex2}%
}

% [brazil]
% Por padrão, assume-se pt_BR, por isso a opção é ignorada
\DeclareOption{brazil}{\OptionNotUsed}

% [lmodern] [times] [arial]
% Escolhe a fonte: lmodern, times (default), ou arial.
%Veja cada um dos \newif para detalhes
\newif\ifufscthesis@lmodern % [lmodern] O ápice da tipografia. A maioria das
                            % pessoas vai achar que é Times

\newif\ifufscthesis@times % [times] Um clone da Times New Roman. Por razões
                          % legais a fonte não pode ser distribuída livremente.
                          % Se você usa windows ou ilegalmente roubou arquivos
                          % TTF, chame a fonte TTF no seu main.tex

\newif\ifufscthesis@arial % [arial] Como no caso da times, problemas de licença
                          % impedem a distribuição da fonte. Se você (ou quem te
                          % mandou usar) pediu arial, você na verdade não se
                          % importa com a fonte e vai ganhar uma helvetica.
                          % Se roubou o TTF ou está no windows,
                          % faça a configuração no main.tex
\ufscthesis@timestrue
\DeclareOption{lmodern}{\ufscthesis@lmoderntrue \ufscthesis@timesfalse \ufscthesis@arialfalse}
\DeclareOption{times}{\ufscthesis@lmodernfalse \ufscthesis@timestrue \ufscthesis@arialfalse}
\DeclareOption{arial}{\ufscthesis@lmodernfalse \ufscthesis@timesfalse \ufscthesis@arialtrue}

% [nocapautoref]
% Por padrão \autoref será configurado para produzir Seção/Section ao invés de seção/section
% Passando essa opção, essa classe não irá alterar o comportamento padrão
\newif\ifufscthesis@nocapautoref
\DeclareOption{nocapautoref}{%
  \ufscthesis@nocapautoreftrue%
}

% [noabntexcite]
% Por padrão o abntex2cite é carregado, incluindo algumas opções pré-definidas
% (veja logo abaixo). Para desativar esse carregamento automático (por exemplo,
% para evitar algumas dessas opções, use a opção noabntex2cite
\newif\ifufscthesis@noabntexcite
\DeclareOption{noabntexcite}{%
  \ufscthesis@noabntexcitetrue%
}

% [nohidelinks]
% Por padrão essa classe desativa cor e bordas no links do documento (hyperref)
% Use essa opção para que hidelinks não seja passado ao hyperref por essa classe
\newif\ifufscthesis@nohidelinks
\DeclareOption{nohidelinks}{%
  \ufscthesis@nohidelinkstrue%
}

% [nocleanheader]
% O @buDoc apresenta headers mais limpos que o padrão do abnTeX2. Por padrão, esta
% classe coloca headers conforme o @buDoc. Use essa opção para restaurar os headers
% padrão do abnTex2
\newif\ifufscthesis@nocleanheader
\DeclareOption{nocleanheader}{%
  \ufscthesis@nocleanheadertrue%
}

% Todas as opções que não foram listadas anteriormente são redirecionadas para o abntex2
\DeclareOption*{%
 \PassOptionsToClass{\CurrentOption}{abntex2}%
}

% Faz a mágica acontecer
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Carregar abnTeX2 e outros pacotes                              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Carrega como base a classe 'abntex2'
\LoadClass[%
  12pt, %@buWord, @buABNT, @buDoc
  a4paper, %@rn46
  twoside, % @buABNT
  chapter=TITLE, % Caixa alta @buDoc @buWord
  section=TITLE  % Caixa alta @buDoc @buWord
                 % Capitalizado para subseção e menor @buDoc @buWord
]{abntex2}

\ifufscthesis@lmodern
  \RequirePackage{lmodern}
\fi
\ifufscthesis@times
  \RequirePackage{mathptmx}
\fi
\ifufscthesis@arial
  \RequirePackage{helvet}
  \renewcommand{\familydefault}{\sfdefault}
\fi

% Identação do primeiro paragráfo
\RequirePackage{indentfirst}

% Número da última página
\RequirePackage{lastpage}

% Citações
\ifufscthesis@noabntexcite\else
  \PassOptionsToPackage{alf,abnt-and-type=&,abnt-doi=link,abnt-url-package=hyperref}{abntex2cite}
  \RequirePackage{abntex2cite}
\fi

\ifufscthesis@nohidelinks\else
  % abntex2 já chama o hyperref
  \AtBeginDocument{\hypersetup{hidelinks}}
\fi

% Coisas usadas para truques aqui na classe
\RequirePackage{etoolbox}
\RequirePackage{ifthen}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% i18n                                                           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifufscthesis@eng
  \newcommand{\ufscthesis@captionsourcelabel}[0]{Source}
  \let\ufscthesis@oldpretextual\pretextual
  \renewcommand{\pretextual}[0]{\ufscthesis@oldpretextual\selectlanguage{english}}
  \let\ufscthesis@oldtextual\textual
  \renewcommand{\textual}[0]{\ufscthesis@oldtextual\selectlanguage{english}}
  \let\ufscthesis@oldpostextual\postextual
  \renewcommand{\postextual}[0]{\ufscthesis@oldpostextual\selectlanguage{english}}
  \selectlanguage{english}

  % Nomeclatura de orientador e Coorientador cf @buABNT. 
  % Esses nomes devem permanecer em pt_BR mesmo para trabalhos escritos em inglês @CitationNeeded
  \addto\captionsenglish{%
    \renewcommand{\orientadorname}{Orientador:}%
    \renewcommand{\coorientadorname}{Coorientador:}%
  }
\else
  % Nomenclatura cf @buDoc e @buABNT
  \newcommand{\ufscthesis@captionsourcelabel}[0]{Fonte}
  \addto\captionsbrazil{%
    \renewcommand{\orientadorname}{Orientador:}%
    \renewcommand{\coorientadorname}{Coorientador:}%
  }
\fi

\ifufscthesis@nocapautoref\else
  \addto\extrasenglish{%
    \renewcommand{\chapterautorefname}{Chapter}%
    \renewcommand{\sectionautorefname}{Section}%
    \renewcommand{\subsectionautorefname}{Subsection}%
    \renewcommand{\subsubsectionautorefname}{Subsubsection}%
  }
  \addto\extrasbrazil{%
    \renewcommand{\chapterautorefname}{Capítulo}%
    \renewcommand{\sectionautorefname}{Seção}%
    \renewcommand{\subsectionautorefname}{Subseção}%
    \renewcommand{\subsubsectionautorefname}{Subsubseção}%
  }
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Comandos gerais                                                %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%\captionsource{<text>}
% Imprime o Fonte: <text> de figuras e tabelas conforme exigido em @buABNT @buDoc
% O Fonte muda para Source quando a opção english é dada para a classe
% Uma quebra de linha será inserida automaticamente
\newcommand{\captionsource}[1]{\begingroup \par \footnotesize \ufscthesis@captionsourcelabel:~#1 \endgroup}

\newcommand{\ifnotempty}[2]{\ifthenelse{\not\equal{#1}{}}{#2}{}}

% O @buDoc usa extensivamente linhas em branco como recurso estético
\newcommand{\ufscthesis@lbreak}[0]{\par\vspace{\baselineskip}\par}

\providecommand{\imprimirfichacatalografica}[0]{%
\clearpage\begingroup\centering\bfseries %
  \vspace*{\fill}%
  A ficha catalográfica deve ser gerada usando o sistema da BU em \url{https://http://ficha.bu.ufsc.br/}. Posteriormente o PDF deve ser incluído via \textbackslash{}includepdf{nome.pdf}%
  \vspace*{\fill}%
\endgroup\clearpage}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Comandos de dados                                              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Comandos de dados - programa
\providecommand{\imprimirprograma}{}
\newcommand{\programa}[1]{\renewcommand{\imprimirprograma}{#1}}

% \titulode{Doutor em Ciência da Computação}
% Define o título ao qual o trabalho corresponde
\newtoggle{ufscthesishastitulode}
\providecommand{\imprimirtitulode}{}
\newcommand{\titulode}[1]{\toggletrue{ufscthesishastitulode}\renewcommand{\imprimirtitulode}{#1}}
\newcommand{\ufscthesis@titulode}[0]{%
  \iftoggle{ufscthesishastitulode}%
    {\imprimirtitulode}%
    {\begingroup \bfseries Erro: defina \textbackslash{}titulode\endgroup}%
}%

% \tese
% \dissertacao
% Define o tipo de trabalho. Você pode usar o \tipotrabalho definido no abnTeX2, 
% mas alguns defaults dessa classe deixarão de ser computados. 
% O mais importante deles é o \preambulo
\newtoggle{ufscthesistese}
\newcommand{\tese}[0]{\toggletrue{ufscthesistese}\renewcommand{\imprimirtipotrabalho}{Tese}}
\newcommand{\dissertacao}[0]{\renewcommand{\imprimirtipotrabalho}{Dissertação}}

% \nivel{<mestrado/doutorado>}
% Nível do trabalho. Usado na folha de certificação cf. @buDoc e @buABNT 
% O valor padrão é inferido pelo uso de \tese ou \dissertacao
\providecommand{\imprimirnivel}{\iftoggle{ufscthesistese}{doutorado}{mestrado}}
\newcommand{\nivel}[1]{\renewcommand{\imprimirnivel}{#1}}

% \centro{<centro>}
% Configura o nome do centro da UFSC
\providecommand{\imprimircentro}{}
\newcommand{\centro}[1]{\renewcommand{\imprimircentro}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Banca e coordenação (folha de certificação)                    %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Uso interno. Lista de membros da banca
\newcommand*\ufscthesis@banca{}
% Uso interno. Lista de membros da banca
\newcommand{\ufscthesis@membrobanca}[2]{#1\par#2}
% 6.61cm medido no template oficial @buWord
\newcommand{\ufscthesis@certificador}[2]{\rule{6.61cm}{1pt}\par#1\par#2\par}

% \membrobanca{<nome>}{<Universidade>}
% Adiciona um membro da 
\newcommand{\membrobanca}[2]{\listadd{\ufscthesis@banca}{#1\par#2}}

\newcommand{\imprimircoordenador}[0]{}
\newcommand{\coordenador}[1]{%
  \renewcommand{\imprimircoordenador}%
  {\ufscthesis@certificador{#1}{Coordenador do Programa}}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Padrões para Comandos de dados do abnTeX2                      %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \preambulo{<texto>}
% Texto padrão conforme @buABNT. Esse default só é configurado se os comandos 
% dessa classe, \tese ou \dissertacao, foram usados
\renewcommand{\imprimirpreambulo}{%
\imprimirtipotrabalho~\iftoggle{ufscthesistese}{submetida}{submetido}~ao %
\imprimirprograma para obtenção do título de \ufscthesis@titulode%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Comandos para configurar data                                  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% \data{1 de janeiro de 2019}
% \dia{<dia>}
% \mes{<mes>}
% \ano{<ano>}
% @buDoc e @buABNT usam a data em duas situações.
% - O ano, na capa e folha de rosto
% - "\dia de \mes de \ano" na folha de certificação
% Por padrão esses três componentes são extraídos da data atual
% Se o usuário usar o comando \data{} esse comando irá 
% sobreescrever a data usada na ficha de certificação. Uma leve 
% bruxaria faz um parsing porco para extrair o ano e usar na 
% capa e folha de rosto.
\providecommand{\imprimirano}{\the\year}
\providecommand{\imprimirmes}{%
  \ifcase \month \or Janeiro\or Fevereiro\or Março%
  \or Abril\or Maio\or Junho\or Julho\or Agosto%
  \or Setembro\or Outubro\or Novembro\or Dezembro\fi%
}
\providecommand{\imprimirdia}{\the\day}
\newcommand{\ano}[1]{\renewcommand{\ano}{\#1}}
\newcommand{\mes}[1]{\renewcommand{\mes}{\#1}}
\newcommand{\dia}[1]{\renewcommand{\dia}{\#1}}
\renewcommand{\imprimirdata}{\imprimirano} % engana abnTeX2

% Uso na folha de certificação
\newcommand{\imprimirdataext}{\imprimirdia{} de \imprimirmes{} de \imprimirano}

% https://tex.stackexchange.com/a/236213
\newcommand*\ufscthesislastword[1]{\expandafter\xreverseit\expandafter{\expandafter}#1 \relax}
\def\xreverseit#1#2 #3{%
  \ifx\relax#3%
  #2%
  \expandafter\xthree
  \fi
  \xreverseit{#1 #2}#3% 
}
\def\xthree#1#2#3{}

% Configura data como no abnTeX2. Forneça a data completa, como 
% irá aparecer na folha de certificação. O ano *deveria* ser extraído
\renewcommand{\data}[1]{%
  \renewcommand{\imprimirdataext}{#1}%
  \renewcommand{\imprimirano}{\ufscthesislastword{#1}}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Formatação                                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Margens
\setlrmarginsandblock{2cm}{3cm}{*}  % {left}{right} no anverso (p. ímpar) @buABNT
\setulmarginsandblock{3cm}{2cm}{*}  % {upper}{lower}                      @buABNT
\checkandfixthelayout%

% Cabeçalho e Rodapé
%   - @buWord diz 2 cm para ambos, com alinhamento vertical superior
%   - Essas configs não tem efeito visual perceptível, provaveis defaults do abnTeX2
\setheadfoot{2cm}{1cm} % {header height}{footsep (from bottom of text)}
\setlength\headsep{1cm} % sep from header bottom to text upper margin
% Aplica mudanças de layout
\checkandfixthelayout%

% Altera o estilo do cabeçalho
\ifufscthesis@nocleanheader\else
  %https://github.com/abntex/abntex2/wiki/HowToCustomizarCabecalhoRodape
  \makepagestyle{estiloufsctextual}
    %%cabeçalhos
    \makeevenhead{estiloufsctextual} %%pagina par
       {\footnotesize \thepage}{}{}
    \makeoddhead{estiloufsctextual} %%pagina ímpar ou com oneside
       {}{}{\footnotesize \thepage}
    %% rodapé
    \makeevenfoot{estiloufsctextual}
       {}{}{}
    \makeoddfoot{estiloufsctextual} %%pagina ímpar ou com oneside
       {}{}{}
  % Aplica o estilo no modo textual
  \let\ufscthesis@oldtextualii\textual
  \renewcommand{\textual}[0]{\ufscthesis@oldtextualii\pagestyle{estiloufsctextual}}
\fi

% Tamanhos e estilos de fontes para chapter e (sub)*section
% Também aplica \noindent @buWord[p.10]
% Para títulos de capítulo ainda parece existir 1em de recuo na esquerda, mas parece ser algo do memoir
\renewcommand{\ABNTEXchapterfont}{\noindent\bfseries} % @buDoc @buWord[p. 8]
\renewcommand{\ABNTEXchapterfontsize}{\normalsize}    % @buDoc @buWord
\renewcommand{\ABNTEXsectionfont}{\noindent\normalfont} % @buDoc @buWord
\renewcommand{\ABNTEXsectionfontsize}{\normalsize}      % @buDoc @buWord
\renewcommand{\ABNTEXsubsectionfont}{\noindent\bfseries} % @buDoc @buWord
\renewcommand{\ABNTEXsubsectionfontsize}{\normalsize}    % @buDoc @buWord
%@buDoc possívelmente contem um erro pois inverte a formatação de subsubsection
%com subsubsubsection indicada no @buWord, além de não estar numerado
%corretamente (falta um ".1")
\renewcommand{\ABNTEXsubsubsectionfont}{\noindent\itshape} % @buWord
\renewcommand{\ABNTEXsubsubsectionfontsize}{\normalsize}   % @buWord
\renewcommand{\ABNTEXsubsubsubsectionfont}{\noindent\normalfont} % @buWord
\renewcommand{\ABNTEXsubsubsubsectionfontsize}{\normalsize}      % @buWord

% Estilos de fonte usados no sumário devem corresponder aos estilos usados
% no títulos @buWord @buDoc

% seções em caixa alta
\let\oldcontentsline\contentsline
\def\contentsline#1#2{%
  \expandafter\ifx\csname l@#1\endcsname\l@section
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi
  {%
    \oldcontentsline{#1}{\MakeUppercase{#2}}%
  }{%
    \oldcontentsline{#1}{#2}%
  }%
}

\renewcommand{\cftsectionfont}{\normalfont}                 % @buDoc @buWord
\renewcommand{\cftsubsectionfont}{\normalfont\bfseries}     % @buDoc @buWord
\renewcommand{\cftsubsubsectionfont}{\normalfont\itshape}   % @buWord
\renewcommand{\cftparagraphfont}{\normalfont}               % @buWord

% Tamanho de fonte em cabeçalhos e rodapés. @buWord, @buDoc
% (o default do abntex2 (footnotesize) já parecia ser 10, mas foi preciso fazer força para afetar figure e table)
\renewcommand{\footnotesize}{\fontsize{10pt}{12pt}\selectfont}
\renewcommand{\ABNTEXfontereduzida}{\footnotesize}
\AtBeginDocument{%
  \captionnamefont{\footnotesize}%
  \captiontitlefont{\footnotesize}%
}

% Espaçamento depois do título
%  - @buDoc deixa sempre 1 linha com esp. 1,5 em branco após chapter, section e subsection. Em LaTeX 1em equivale a altura de uma linha, por isso 1.5em. Com normalsize sendo 12pt, 1em=18pt=0.6326cm. O ufsc-thesis do Mateus Dubiela usava 0.38cm para chapskip e deixava o padrão para os demais
\setlength{\afterchapskip}{1.5em}
\setlength{\aftersecskip}{1.5em}
\setlength{\aftersubsecskip}{1.5em}
% - Essa prática do @buDoc não é estéticamente agradável. Mas foi mantida pois o template a utiliza até subseções (não há exemplos para os níveis inferiores). Como por algum motivo não é possível controlar o espaçamento de sub-sub-subseção (o chapskip é usado), optou-se por aplicar o mesmo espaçamento para tudo que pode ser configurado
\setlength{\aftersubsubsecskip}{1.5em}

% Espaçamento depois dos paragráfos @buDoc @buWord
\setlength{\parskip}{0.0cm}
% De acordo com @buABNT, na bibliografia deve haver uma linha em branco entre entradas
\let\ufscthesis@oldthebibliography\thebibliography
\renewcommand{\thebibliography}[1]{%
  \ufscthesis@oldthebibliography{#1}%
  % o +.2 é o interlineskip, pra criar a ilusão de que o autor cometeu a
  % heresia de separar as entradas com uma quebra de parágrafo
  \setlength{\parskip}{1.2em}
}
% Espaçamento da primeira linha do parágrafo @buDoc @buWord
\setlength{\parindent}{1.5cm}
% Espaçamento entre linhas de 1,5 @buDoc @buWord @buABNT
%\OnehalfSpacing
\SingleSpacing
% Lugares que exigem espaçamento entre linhas simples @buWord[p. 7]
% - Floats (figure/table): Fracassei em alterar, mas default já é SingleSpacing
% - footnotes: Fracassei em alterar, mas default já é SingleSpacing
% - referencias: Nem tentei alterar, mas o default já é SingleSpacing


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Comandos para gerar elementos especiais                        %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Ficha catalográfica foi removida, pois deve ser gerada em http://ficha.bu.ufsc.br/

% Folha de rosto segundo modelo da Biblioteca Universitária da UFSC
\renewcommand{\folhaderostocontent}{
  \begin{center}
    % Nome do autor em caixa baixa sem negrito
    {\ABNTEXchapterfont\textmd\imprimirautor}
    \vspace*{\fill}
    % Título do trabalho em caixa alta e negrito
    \begin{center}
      \MakeTextUppercase{\ABNTEXchapterfont\bfseries\large\imprimirtitulo}
    \end{center}
    \vspace*{1cm}
    % Preâmbulo seguido de nomes do orientador e coorientador com recuo
    \abntex@ifnotempty{\imprimirpreambulo}{%
      \hspace{.45\textwidth}
      \begin{minipage}{.5\textwidth}
        \ABNTEXfontereduzida
        \SingleSpacing
        \imprimirpreambulo

        % Nomes do orientador e coorientador
        {\imprimirorientadorRotulo~\imprimirorientador\par}
        \abntex@ifnotempty{\imprimircoorientador}{%
           {\imprimircoorientadorRotulo~\imprimircoorientador}%
        }%
      \end{minipage}%
      \vspace*{\fill}
    }%
    \vspace*{\fill}

    % Local e data em caixa baixa sem negrito
    {\imprimirlocal}
    \par{\imprimirano}
    \vspace*{1cm}
  \end{center}
}

% Origem: @buDoc e @buABNT Atenção o uso de \vspace*{\fill} nos
% locais usados foi uma advinhação do autor que vos fala. Não há
% nenhuma instrução da BU sobre os espaçamentos verticais na folha de
% certificação.  No @buDoc foi observado um uso de espalamento de
% elementos que variava de 1 a 3 line breaks. Na parte superior eram
% usados menos line breaks e na parte inferior, mais. Isso indica a
% intenção de quem fez o @buDoc em aglutinar mais na parte superior e
% espaçar mais na parte inferior.  Quando essas interpretações são
% colocadas em fonte Times, há muito mais espaço disponível, o que
% torna o uso de um único ufscthesis@lbreak esteticamente feio pois
% causa um desbalancemento notável. A solução foi classificar os
% linebreaks do @buDoc entre os de uma linhas e os de 2+ linhas. Para os
% de 2+ linhas são usados 2 \vspace*{\fill}, enquanto que nos usos de um
% line break, aqui usamos apenas um fill. Isso de certa forma mantem
% proporcionalmente a distribuição vertical do @buDoc. Para os membros
% de banca, foi mantido fixo o uso de um único line break acima de cada
% membro. No caso dos "certificadores" (Coordenador e Orientador) foi
% usado fill duplo (3 linhas no @buDoc).
\newcommand{\folhadecertificacaocontent}{
  \begin{center}
    \normalsize
    \OnehalfSpacing %usado na folha inteira
    % Nome do autor em caixa baixa sem negrito
    {\imprimirautor} \par
    % Apenas 1,5 de espaço Título em negrito (e subtitulo sem)
    {\centering\bfseries \imprimirtitulo} \par
    \vspace*{\fill}
    %\ufscthesis@lbreak % uma linha em branco
    O presente trabalho em nível de \imprimirnivel foi avaliado e aprovado por banca examinadora composta pelos seguintes membros:
    % Imprime os membros (sem linhas para assinatura)
    \forlistloop{\ufscthesis@lbreak}{\ufscthesis@banca} \par
    \vspace*{\fill}
    \vspace*{\fill}
    Certificamos que esta é a {\bfseries versão original e final} de conclusão que foi julgado adequado para obtenção do título de \ufscthesis@titulode. \par
    \vspace*{\fill}
    % Pessoas que assinam o documento (por isso eles tem a linha)
    \imprimircoordenador
    \vspace*{\fill}
    \ufscthesis@certificador{\imprimirorientador}{Orientador}
    \vspace*{\fill}
    \vspace*{\fill}
    % Local e data em caixa baixa sem negrito
    \imprimirlocal, \imprimirdataext.
  \end{center}
}

\newcommand{\imprimirfolhadecertificacao}[0]{\clearpage\folhadecertificacaocontent\clearpage}


\endinput
