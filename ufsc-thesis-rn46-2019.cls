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
% Escolhe a fonte: lmodern (default), times, ou arial. 
%Veja cada um dos \newif para detalhes
\newif\ifufscthesis@lmodern % [lmodern] O ápice da tipografia. A maioria das 
                            % pessoas vai achar que é Times
\ufscthesis@lmoderntrue   
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

% Manipulação de Strings
\RequirePackage{xstring}

% Tamanho das fontes
\RequirePackage{anyfontsize}

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
  \PassOptionsToPackage{hidelinks}{hyperref}
  % abntex2 já chama o hyperref
  %\AtBeginDocument{\RequirePackage{xepersian}}
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
\else
  \newcommand{\ufscthesis@captionsourcelabel}[0]{Fonte}
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

% Comandos de dados - programa
\providecommand{\imprimirprograma}{}
\newcommand{\programa}[1]{\renewcommand{\imprimirprograma}{#1}}

\newcounter{ufscthesis@assuntos}
\providecommand{\listaassuntos}{}
\providecommand{\imprimirassuntos}{%
  \setcounter{ufscthesis@assuntos}{1}
  \@for\assunto:={\listaassuntos}\do{%
    \arabic{ufscthesis@assuntos}.\assunto. %
    \addtocounter{ufscthesis@assuntos}{1}
  }
}
\newcommand{\assuntos}[1]{\renewcommand{\listaassuntos}{#1}}

\providecommand{\imprimircentro}{}
\newcommand{\centro}[1]{\renewcommand{\imprimircentro}{#1}}


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

% Tamanhos e estilos de fontes para chapter e (sub)*section
\renewcommand{\ABNTEXchapterfont}{\bfseries}       % @buDoc @buWord[p. 8]
\renewcommand{\ABNTEXchapterfontsize}{\normalsize} % @buDoc @buWord
\renewcommand{\ABNTEXsectionfont}{\normalfont}     % @buDoc @buWord
\renewcommand{\ABNTEXsectionfontsize}{\normalsize} % @buDoc @buWord
\renewcommand{\ABNTEXsubsectionfont}{\bfseries}       % @buDoc @buWord
\renewcommand{\ABNTEXsubsectionfontsize}{\normalsize} % @buDoc @buWord
%@buDoc possívelmente contem um erro pois inverte a formatação de subsubsection com subsubsubsection indicada no @buWord, além de não estar numerado corretamente (falta um ".1")
\renewcommand{\ABNTEXsubsubsectionfont}{\itshape}        % @buWord 
\renewcommand{\ABNTEXsubsubsectionfontsize}{\normalsize} % @buWord
\renewcommand{\ABNTEXsubsubsubsectionfont}{\normalfont}     % @buWord
\renewcommand{\ABNTEXsubsubsubsectionfontsize}{\normalsize} % @buWord

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
    \par{\imprimirdata}
    \vspace*{1cm}
  \end{center}
}


\endinput
