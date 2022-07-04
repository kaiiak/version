%{
package version

func setResult(l yyLexer, v Result) {
  l.(*lex).result = v
}
%}

%union{
  version Version
  part string
  ch byte
}

%token <version> version
%token <ch> D
%type <part> area part1 part2

%start main

%%
/* 规则部分 */
main: version
  {
    setResult(yylex, $1)
  }

version:
  area part1 part2
  {
    $$ = Result{area: $1, part1: $2, part2: $3}
  }
| area '.' part1 '.' part2
  {
    $$ = Result{area: $1, part1: $3, part2: $5}
  }

area: D D D
  {
    $$ = cat($1, $2, $3)
  }

part1: D D D
  {
    $$ = cat($1, $2, $3)
  }

part2: D D D D
  {
    $$ = cat($1, $2, $3, $4)
  }