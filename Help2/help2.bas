Option explicit

Sub genIndex()
  Local gen_index%=0
  Local genId% = 0
  If gen_index% = 1 Then
    Print "Generating help index"
    cn%=0
    Open "full_help.txt" For input As #1
    Open "helpInd.dat" For output As #2
      Do While Not Eof(#1)
        Line Input #1, l$

        If Mid$(l$,1,1) = "~" Then
          Print #2, trim$(l$);
          Line Input #1, t$
          Print #2, Loc(#1)

          cn%=cn%+1
          If cn% Mod 100 Then
            Print "Entries indexed: ";
            Print cn%
          End If
        End If
      Loop
    Close #1
    Close #2
  End If
End Sub

Function getHelpTitle$(l$)
  Local p%
  p% = Instr(l$,"*")
  getHelpTitle$ = trim$(Mid$(l$,1,p%-1))
End Function

Function getHelpIndex%(l$)
  Local p%
  Local t$
  p% = Instr(l$,"*")
  t$ = trim$(Mid$(l$,p%+1,Len(l$)-p%+1))
  getHelpIndex%=Val(t$)
End Function

Sub waitForKey()
  Print ""
  Print "-- press a key --"
  Print ""
  Do While Inkey$ = ""
  Loop
End Sub


Sub getHelp(find%)
  Const charMax%=40
  Const lineMax%=15

  Local c$ = ""
  Local ln%=0
  Local char%=0
  Local word$=""
  Local w%=0

  Open "full_help.txt" For random As #3
    Seek #3, find%
    Do While c$ <> "~"
      c$ = Input$(1, #3)
      If c$ <> "~" Then
        If c$ = Chr$(13) Then
          Print ""
          char%=0
          ln% = ln%+1
          If word$<>"" Then
            Print word$;
            char%=Len(word$)
            word$ = ""
          End If
        Else If c$ = " " Then
          w% = Len(word$)
          If char%+w%<charMax% Then
            Print word$;
            word$ = ""
            char%=char%+w%
            If char%+1<charMax% Then
              Print " ";
              char%=char%+1
            Else
              Print
              char%=0
              ln%=ln%+1
            EndIf
          Else
            Print ""
            Print word$;
            Print " ";
            char% = w% +1
            word$ = ""
            ln% = ln%+1
          EndIf
        Else
          word$=word$+c$
        End If

        If ln% > lineMax% Then
          ln%=0
          char%=0
          waitForKey()
        EndIf
      End If
    Loop
  Close #3
End Sub

Sub Help2(si$)
  Local ext% = 1
  Local title$
  Local loc%
  Local search$=si$
  Local a$
  Local i%
  Local ind%(20)
  Local count%=0
  CLS
  genIndex()
  Print "PicoCalc Help Search  (v1.0)"
  Print "--------------------"
  Print ""
  Print "Searching ..."
  Print ""

  If Instr(search$, "*") Then
    ext% = 0
    search$=Mid$(si$,1,Len(si$)-1)
  End If

  search$=LCase$(search$)

  Open "helpind.dat" For input As #1
    Do While Not Eof(#1)
      If count% < 20 Then
        Line Input #1, a$
        title$=LCase$(getHelpTitle$(a$))
        If ext% Then
          If title$=search$ Then
            Print title$
            loc%=getHelpIndex%(a$)
            ind%(count%)=loc%
            count%=count%+1
          EndIf
        Else
          If Instr(title$,search$) Then
            loc%=getHelpIndex%(a$)
            ind%(count%)=loc%
            count%=count%+1
          End If
        End If
      Else
        Exit Do
      End If
    Loop
  Close #1

  If count% >0 Then
    For i%=0 To count%-1
      Print ""
      getHelp(ind%(i%))
      If i% < count%-1 Then
        waitForKey()
      End If
    Next
  Else
    Print "Nothing found."
    Print "Try a wildcard search."
    Print
  End If
End Sub
