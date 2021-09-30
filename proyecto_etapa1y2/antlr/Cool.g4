grammar Cool;           

program
    : ( klass ';' )  
    ;

klass
    : KLASS TYPE ( 'inherits' TYPE )? '{' ( feature ';' )* '}'
    ;


feature
    : ID '(' ( formal (',' formal)* )? ')' ':' TYPE '{' expr '}' #method //x
    | ID ':' TYPE ('<-' expr)?  #attribute
    ;

formal
    : ID ':' TYPE
    ;

expr
    :
    primary                                         #base
    |  ID '<-' expr                                 #assign
    |  ID '(' (expr (',' expr)*)? ')'               #simplecall //x
    |  IF '(' expr ')' THEN'(' expr ')' ELSE'(' expr ')' FI      #if //x
    |  WHILE'(' expr ')'LOOP'(' expr ')'POOL        #while //x
    |  ID '(' (expr (',' expr)*)? ')'           #objectcall
    |  LET let_decl (',' let_decl)* 'in' expr       #let
    |  CASE expr OF case_stat+ ESAC                 #case //x
    |   NEW expr                                    #new
    |   LBRACE expr ';'+ RBRACE                     #block //x
    |   ID '@' TYPE '(' (expr (',' expr)*)? ')' #at //x
    |   '~'expr             #neg
    |   VOID expr           #isvoid
    |   expr'*'expr         #mult
    |   expr '/' expr       #div
    |   expr '+' expr       #plus  
    |   expr '-' expr       #less
    |   expr '<' expr       #lt
    |   expr '<=' expr      #le
    |   expr '==' expr      #eq
    |   'not' expr          #not
    |   expr '=' expr ';'   #assign
    ;

case_stat:ID ':' TYPE '=>' expr ';'  ;

let_decl:  ID ':' TYPE ('<-' expr)?  ;

primary:
        INT             #int
    |   STRING          #string
    |   TRUE            #true
    |   FALSE           #false
    |   ID              #id
    |   '(' expr ')'    #parens
    ;

/*
Integers son non empyu sting 0-9
Identifyers son strings letters, digits y _. 
    Type Empiezan con Mayuscula. 
    object empiezan con lower case
    self
    SELF_TYPE
Strings estan entre " " 

 */

KLASS   : 'class';


BOOL    : 'bool';
INTEGER : 'int';
PRINT   : 'print';
FI      : 'fi' ;
IF      : 'if';
WHILE   : 'while' ;
NEW     : 'new';
INHERITS  : 'inherits';
LET     : 'let';
VOID    : 'isvoid';
LOOP    : 'loop' ;
POOL    : 'pool' ;
THEN    : 'then' ;
ELSE    : 'else' ;
CASE    : 'case' ;
ESAC    : 'esac' ;
OF      : 'of'  ;
NOT     : 'not' ;
TRUE    : 'true';
FALSE   : 'false' ;
LBRACE : '{';
RBRACE : '}';



INT     : [0-9]+ ; // bien
TYPE    : [A-Z][a-zA-Z0-9_]*  ;
//OBJ_ID  : [a-z][a-zA-Z0-9_]*  ;
STRING  : '"' .*? '"' ;
ID      : [A-Za-z0-9_]+;

COMMENT : '--' .*? '\n' -> skip ;
BLOCK_COMMET : '(*' .*? '*)' -> skip ;

WS : [ \t\n\r\f]+ -> skip ;