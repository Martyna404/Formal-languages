task1 


%option noyywrap

%{
    #include <iostream>
    #include <cstdlib>
    #include <cstdio>
    #include <set>
    #include <string>

    extern FILE *yyin;
    std::set<std::string> labels;
%}

%%

^[a-zA-Z0-9._+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}  { 
    printf("Valid email detected: %s\n", yytext);
    labels.insert(std::string(yytext));
}

%%

int main() {
    FILE *file = fopen("input.txt", "r");
    if (!file) {
        std::cerr << "Error opening file!" << std::endl;
        return 1;
    }
    
    yyin = file;
    yylex();  
    
   
    std::cout << "Detected emails:\n";
    for (const auto& t : labels) {
        std::cout << t << std::endl;
    }
 
    fclose(file);
    return 0;
}

