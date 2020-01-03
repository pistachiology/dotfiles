syntax match div "//" conceal cchar=÷
syntax match mul "*" conceal cchar=×
syntax match eq "==" conceal cchar=≣
syntax match neq "!=" conceal cchar=≠
syntax match gteq ">=" conceal cchar=≥
syntax match lteq "<=" conceal cchar=≤

syntax match arrow "->" conceal cchar=→
syntax match rpipe "|>" conceal cchar=⊳
syntax match lpipe "<|" conceal cchar=⊲
syntax match rcomp ">>" conceal cchar=»
syntax match lcom "<<" conceal cchar=«
syntax match lambda "\\" conceal cchar=λ
syntax match cons "::" conceal cchar=∷
syntax match parse1 "|=" conceal cchar=⊧
syntax match parse2 "|." conceal cchar=⊦
syntax match neq "/=" conceal cchar=≠

syntax match fatRightArrowHead contained ">" conceal cchar= 
syntax match fatRightArrowTail contained "=" conceal cchar=⟹
syntax match niceOperator "=>" contains=fatRightArrowHead,fatRightArrowTail
