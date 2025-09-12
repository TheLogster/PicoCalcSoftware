
Function LTrim$(s$)
  ltrim$ = s$
  Do While Instr(" ", Left$(ltrim$, 1))
    ltrim$=Mid$(ltrim$, 2)
  Loop
End Function

Function RTrim$(s$)
  rtrim$=s$
  Do While Instr(" ",Right$(rtrim$,1))
    rtrim$=Mid$(rtrim$,1,Len(rtrim$)-1)
  Loop
End Function

Function Trim$(s$)
  trim$=LTrim$(s$)
  trim$=RTrim$(trim$)
End Function
