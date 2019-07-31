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
\OnehalfSpacing

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
