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

\DeclareOption*{%
 \PassOptionsToClass{\CurrentOption}{abntex2}%
}
\ProcessOptions\relax

% Carrega como base a classe 'abntex2'
\LoadClass[%
  12pt, %@buWord, @buABNT, @buDoc
  a4paper, %@rn46
  twoside, % @ABNT
  chapter=TITLE, % Caixa alta @buDoc
  section=TITLE  % Caixa alta @buDoc
                 % Capitalizado para subseção e menor @buDoc
]{abntex2}

% Manipulação de Strings
\RequirePackage{xstring}

% Tamanho das fontes
\RequirePackage{anyfontsize}

% TODO Colocar times caso o usuário queira, fonte matemática zuada
% Fonte 'Times New Roman'
\RequirePackage{mathptmx}

% Identação do primeiro paragráfo
\RequirePackage{indentfirst}

% Número da última página
\RequirePackage{lastpage}

\RequirePackage{ifthen}
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


% Margens
\setlrmarginsandblock{2cm}{3cm}{*}  % {left}{right} no anverso (p. ímpar) @buABNT
\setulmarginsandblock{3cm}{2cm}{*}  % {upper}{lower}                      @buABNT
\checkandfixthelayout%

% Fontes dos títulos e seções
\renewcommand{\ABNTEXchapterfont}{\bfseries}
\renewcommand{\ABNTEXchapterfontsize}{\normalsize}
\renewcommand{\ABNTEXsectionfont}{\normalfont}
\renewcommand{\ABNTEXsectionfontsize}{\normalsize}
\renewcommand{\ABNTEXsubsectionfont}{\bfseries}
\renewcommand{\ABNTEXsubsectionfontsize}{\normalsize}

% Espaçamento depois do título
\setlength{\afterchapskip}{0.38cm}
% Espaçamento depois dos paragráfos
\setlength{\parskip}{0.0cm}
% Espaçamento da primeira linha do parágrafo
\setlength{\parindent}{1.0cm}
% Comando para inverter sobrenome e nome
\newcommand{\ufscthesis@inverter}[1]{%
  \StrBehind{#1}{{}},
  \StrBefore{#1}{{}}
}

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
